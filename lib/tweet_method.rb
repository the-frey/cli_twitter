require 'rubygems'
require 'oauth'
require 'json'

$:.unshift File.expand_path(File.dirname(__FILE__))

require 'keys'
require 'http'
require 'choices'

module TweetMethod

	include Keys
	include Http
	include JSON
	include Choices

	def tweet_method(consumer_key, access_token, choice)

		case choice

		when "tweet"
			tweet
			return choice
		when "check" 
			check
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