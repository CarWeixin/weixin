#encoding: utf-8	

class ApiTest
	def self.test_url 
		"http://127.0.0.1:3000/"
	end

	def self.get
		connection = Faraday.new( :url => test_url )
		#response = connection.post( "/tokens/get", {:signature => "abae9e65900515726a9aff67e260272d2cb34430" , :timestamp => "sdafdsv" , :nonce => "adasdhoiahf" , :echostr=>"abcdefg"}).body

		response = connection.post( "/tokens/get", {:xml=>{:ToUserName=>"wx7ebbb056cec7e96d", :Encrypt=>"y75WbQj72JGoM3Y8HbmoUURwJEv/t/gAANWS0Rn4jp3yXOKxwyFc8hSfI7biWsU/8b3BtYzhZcpS750UZ9hD+yi5jwvlriHarOUZo8USg679nlbLkqycpQL009k+r9CqaQgbcGcxCuO+bWWpXVXJ+DjI4tcuFrHmgGRvTu+VaAnKFyDuJRehrt7EOIIhDFWCgc/HuOQqSGUd90N6QYHngFNtBaJ42xlfYN5bsdwkkcOXKCqLtncUg260IOQt2PuSbg1TlldE1OPim8cQ+jAx6cb3SYNAzZ0VpcNWttGbjO2V+IpMihv0rvdRUbr39s3xPt+nNmy3AQdVxDLjMp5mzOhnPtnbXQxRADv0X2Ev9Z4p/hMvsgCMWvX3XpHlczuyA8vCC19v8oduQEM14u5Fsh476lPRgC8kd6TUaT8HLKzUDtxnzAs/MF6H4N+FpathpvhKtyTVB6CXpPWtdrMGtQ==", :AgentID=>"3"}, :msg_signature=>"49b3aa035cfbf2168ad872353a93c866492e2c50", :timestamp=>"1459492810", :nonce=>"988598230"}).body


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


