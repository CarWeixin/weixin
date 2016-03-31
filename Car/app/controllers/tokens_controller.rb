#encoding: utf-8
class TokensController < ApplicationController
require 'base64'
require 'digest/sha1'
require 'nokogiri'

	def get
			sign = params[ :msg_signature]
			time = params[ :timestamp]
			nonce = params[ :nonce]
			echostr = params[ :echostr]

	 		token = "huyindianzishangwu"

	 		key = "LJXG9kp4yuCVtkBtTfYRVmUBP5vHYTK4bUL29SMeYxu"

	 		corpID = "wx7ebbb056cec7e96d"

	 		content, status = Prpcrypt.decrypt( key, echostr, corpID ) 
      		
	# 		AESKey = Base64.decode64(EncodeingAESKey + "=" )

	# 		AESKey = "\x74\x92\xc5\x10\x12\x84\xa7\x18\x73\x58\x92\xed\xdc\x96\xd4\x73\x87\x5d\x03\x67\x16\x60\x47\xcd\xc0\xe3\x58\x5b\xda\xee\x19\xa9" 

	# 		AESKey = AEKKey[0..15]

	# 		msg_encrypt = echostr

	# 		array = [token , time , nonce, msg_encrypt]

	# 		array = array.sort 

	# 		str = array[0] + array[1] + array[2] + array[3]

	# 		str = Digest::SHA1.hexdigest(str)

	# 				Base64.decode64(msg_encrypt)

	# 		#render(:text => str)
		
	# 		if str == sign 
	# 		    render    	
	# 			return true
	# 		end
		render :text => content
	end

	def post

		connection = Faraday.new( :url => "https://qyapi.weixin.qq.com/" )
		response = connection.get("cgi-bin/gettoken?corpid=wx703900237aee25ec&corpsecret=FEuzM1J0hAUC_8Jck7MJpYmHbRmYXAMmoYX4siDBLx7H3_P1ybJaW2vmR8rcMVit", ).body

		token = JSON.parse(response)["access_token"]

		json = {
		:touser => "xuranci|luguangyao",
		:msgtype => "text",
		:agentid => "5",
		:text => {
			:content => "李四你好，请于" +  Time.now.to_formatted_s(:time).to_s + "到海洋大学临港校区接张三到人民广场,联系电话13800138000。确认请回复1，谢谢！"
			}
		}
 
		Infomation.create(
			:name => "张三",
			:phone => "13800138000",
			:start_time => Time.now,
			:start => "海洋大学临港校区",
			:end => "人民广场"
			)


		json = JSON.generate(json.as_json)

		connection = Faraday.new( :url => "https://qyapi.weixin.qq.com/" )

		response = connection.post( "/cgi-bin/message/send?access_token=" + token, json).body		
		puts response
		
		render(:text => "车辆预定成功"	)

	end

	def ready

		connection = Faraday.new( :url => "https://qyapi.weixin.qq.com/" )
		response = connection.get("cgi-bin/gettoken?corpid=wx703900237aee25ec&corpsecret=FEuzM1J0hAUC_8Jck7MJpYmHbRmYXAMmoYX4siDBLx7H3_P1ybJaW2vmR8rcMVit", ).body

		token = JSON.parse(response)["access_token"]



		json = {
		:touser => "xuranci|luguangyao",
		:msgtype => "text",
		:agentid => "4",
		:text => {
			:content => "驾驶员李四已经到达，李四电话：13213213213"
			}
		}
 

		json = JSON.generate(json.as_json)

		connection = Faraday.new( :url => "https://qyapi.weixin.qq.com/" )

		response = connection.post( "/cgi-bin/message/send?access_token=" + token, json).body		
		puts response
		
		render(:text => "就位确认成功"	)

	end


end
