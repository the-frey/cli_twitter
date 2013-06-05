module Http
	def http_generator(path)

		baseurl = "https://api.twitter.com"
		self.address = URI("#{baseurl}#{path}")

		if @address
			http = Net::HTTP.new @address.host, @address.port
			http.use_ssl = true
			http.verify_mode = OpenSSL::SSL::VERIFY_PEER
			http
		else
			raise Exceptions::NoAddressError, 'An address could not be built from that path.'
		end
	end

	def request_generator(address,type)
		type.downcase!
		if type == "post"
			Net::HTTP::Post.new address.request_uri
		elsif type == "get"
			Net::HTTP::Get.new address.request_uri
		else
			raise Exceptions::IncorrectHTTPVerb, 'The HTTP verb was not recognized.'
		end
	end

	def address=(address)
		@address = address
	end

	def address_path
		@address
	end
end