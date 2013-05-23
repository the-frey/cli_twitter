module Keys
	CONSUMER_KEY1 = "" #consumer key
	CONSUMER_KEY2 = "" #consumer secret
	ACCESS_TOKEN1 = "" #access token
	ACCESS_TOKEN2 = "" #access secret

	def consumer_key 
		OAuth::Consumer.new(CONSUMER_KEY1,CONSUMER_KEY2)
	end

	def access_token
		OAuth::Token.new(ACCESS_TOKEN1,ACCESS_TOKEN2)
	end
end