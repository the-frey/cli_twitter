require 'rubygems'
require 'oauth'
require 'json'

$:.unshift File.expand_path(File.dirname(__FILE__))

require 'keys'
require 'http'

module TweetMethod

	include Keys
	include Http
	include JSON

	def tweet_method(consumer_key, access_token, choice)

		case choice

		when "tweet"
			puts "What do you want to tweet?"
			print "> "
			tweet_text = STDIN.gets.chomp
			#tweet_text.to_s

			if tweet_text.length > 140
				tweet_invalid = true
				abort("The tweet is too long (#{tweet_text.length}).")
			end

			path = "/1.1/statuses/update.json"

			http = http_generator(path)
			
			address = address_path

			request = Net::HTTP::Post.new address.request_uri
			request.set_form_data(
				"status" => "#{tweet_text}"
				)

			#Debugger
			#puts http.set_debug_output($stderr)

			#Issue the request
			request.oauth! http, consumer_key, access_token
			http.start
			response = http.request request unless tweet_invalid == true

			#Parse and print the tweet if the response code was 200
			tweet = nil
			if response.code == '200'
				tweet = JSON.parse(response.body)
				puts "Successfully posted Tweet: #{tweet["text"]}."
			else
				puts "Could not send the Tweet! " + "Code: #{response.code} \nBody: #{response.body}"
			end 
			return choice
		when "check" 
			# All requests will be sent to this server.
			query = URI.encode_www_form(
					"screen_name" => "hipsters_unite",
					"count" => "10",
					"contributor_details" => true
				)

			path = "/1.1/statuses/mentions_timeline.json?#{query}"

			http = http_generator(path)

			address = address_path

			def print_mentions(tweets)
				#puts JSON.pretty_generate(tweets)
				tweets.each do |t|
					output = ""
					output << "#{t["user"]["name"]} "
					output << "(#{t["user"]["screen_name"]}) "  
					output << "#{t["created_at"]}: \n" 
					output << "#{t["text"]}\n\n"
					output << "--- \n\n"
					puts output
				end
			end

			#debugger
			#puts http.set_debug_output($stderr)

			# Build the request and authorize it with OAuth.
			request = Net::HTTP::Get.new address.request_uri
			request.oauth! http, consumer_key, access_token

			# Issue the request and return the response.
			http.start
			response = http.request request

			tweets = nil
			if response.code == '200'
				tweets = JSON.parse(response.body)
				print_mentions(tweets)
			else
				puts "Failed, response #{response.code}"
			end
			return choice
		when "exit"
			sec = Time.now.sec
			i = sec + 3
			until sec == i
				print "."
				until Time.now.sec == sec + 1
					#do nothing
				end
				sec += 1
			end
			abort("Quitting...")
		when "help"
			puts "Type 'Tweet' or 'tweet' to compose a tweet."
			puts "Type 'Check' or 'check' to check your mentions."
			puts "Type 'exit' to quit."
			return choice
		else
			puts "I don't understand that! Use 'check' to check tweets or 'tweet' to compose a tweet."
			return choice
		end
	end
end