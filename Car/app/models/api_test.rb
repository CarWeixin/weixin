#encoding: utf-8	

class ApiTest
	def self.test_url 
		"http://127.0.0.1:3000/"
	end

	def self.get
		connection = Faraday.new( :url => test_url )
		#response = connection.post( "/tokens/get", {:signature => "abae9e65900515726a9aff67e260272d2cb34430" , :timestamp => "sdafdsv" , :nonce => "adasdhoiahf" , :echostr=>"abcdefg"}).body

		response = connection.post( "/tokens/get", {:xml=>{:ToUserName=>"wx7ebbb056cec7e96d", :Encrypt=>"v3BO+xr17rUmL+vlsycBj6Jo6TWPMmTTKqxpYLvcDChQamgTrHwIMiGPT6UII7v3xB6JdScKTiQa1sz0xbBLGn092aMswB98cWAIptOmGmQ68HFMhpMb0MsZ+oLpdXFBUavVh+JkD9RqEjCHFiVBRuMMvhr2rARt/K+74T9aklfkfThmNNpnkVWpWsrikhKF5H/F77iIH7z1prnKwDotlTXkpaBRnor3wkaGMn39szABAONIPUZsBt0qfs409KMwKQiDTUskeBOfKcTdf4aDGVQguzpY+sOBaPPLa/mSumCmWtE1GgfZXmyloP6mGBWFvsIlyhcBepbkWhmHEVldlzMGpV1PXH1aRxZaqs1qgSPFChuC3t63rQ/C//FgwkICLk9wqfhUrktAVWbBnh5PGImvNgOZGSNEx/CON4BmSm/Ano8nE72Fr15qK/o0jp1jtoxOkyFU1WKAHcyelXSmGA==", :AgentID=>"3"}, :msg_signature=>"49b3aa035cfbf2168ad872353a93c866492e2c50", :timestamp=>"1459492810", :nonce=>"988598230"}).body


		puts response
	end

	def self.post
		connection = Faraday.new( :url => test_url )
		
		response = connection.post( "/tokens/post").body
		puts response
	end


	def self.ready
		connection = Faraday.new( :url => test_url )
		
		response = connection.post( "/tokens/ready").body
		puts response
	end



	def self.button
		connection = Faraday.new( :url => test_url )
		
		response = connection.post( "/tokens/button").body
		puts response
	end

end


