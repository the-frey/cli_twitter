
puts <<MESSAGE
	       
	     
	    |     // _     _  _   _ _   _
	    | /| // |_ |  |  | | | | | |_
	    |/ |//  |_ |_ |_ |_| |   | |_

   Command line Twitter was hacked together with love 
   in Manchester, UK. Tweet me: @hipsters_unite

MESSAGE

$:.unshift File.expand_path(File.dirname(__FILE__))

require 'lib/tweet_method'

class UserInput

	include TweetMethod

	def initialize 
		@choice = nil
	end

	def choice_loop
		until @choice == "exit"
			puts "What do you want to do? Use 'check', 'tweet' or 'exit'."
			print "> "
			@choice = STDIN.gets.chomp
			@choice.downcase!
			tweet_method(consumer_key, access_token, @choice) 
			puts "\n\n---------"
		end
	end
end

tweeter = UserInput.new

tweeter.choice_loop