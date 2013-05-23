module Http
	# Set up Net::HTTP to use SSL, which is required by Twitter.
	def http_generator(path)
		@baseurl = "https://api.twitter.com"
		self.address = URI("#{@baseurl}#{path}")
		@http = Net::HTTP.new @address.host, @address.port
		@http.use_ssl = true
		@http.verify_mode = OpenSSL::SSL::VERIFY_PEER
		@http
	end

	def address=(address)
		@address = address
	end

	def address_path
		@address
	end
end