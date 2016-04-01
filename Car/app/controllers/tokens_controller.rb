#encoding: utf-8
#decoding: utf-8

class TokensController < ApplicationController
require 'base64'
require 'digest/sha1'
require 'nokogiri'
require 'net/http'

	def get
			sign = params[ :msg_signature]
			time = params[ :timestamp]
			nonce = params[ :nonce]
			echostr = params[ :echostr]

	 		token = "huyindianzikeji"

	 		key = "d2l1ZHczNDVqdXd1aWpzbmNoODc4d2tzamhpdXllc3I"

	 		corpID = "wx7ebbb056cec7e96d"
	 		corpsecret = "3sryz04qwCwaQG_sECT_iqUgHjqRkvzPN7RWSKUjysScTbNGHpYd6E9Zc31fXJkZ"

			aeskey = Base64.decode64( key + "=" )	 		

			if !echostr.nil?

		 		content, status = Prpcrypt.decrypt( aeskey , echostr, corpID ) 
				
				render :text => content
			else
				xml = params[ :xml]

				content, status = Prpcrypt.decrypt( aeskey , xml[ :Encrypt] , corpID)

				content = Hash.from_xml(content)

				content = content["xml"]

				connection = Faraday.new( :url => "https://qyapi.weixin.qq.com/" )	
				response = connection.get("cgi-bin/gettoken",{:corpid => corpID , :corpsecret => corpsecret}).body				
				access_token = JSON.parse(response)["access_token"]

				if content["MsgType"] == "event" 
	

					if content["EventKey"] == "绑定" 


						msg = "请输出18位身份证号码"
						msgtype = "text"
				

					elsif content["EventKey"] == "获取二维码"

						msgtype = "image"

						connection = Faraday.new( :url => "http://my.tv.sohu.com/" )
						image = connection.post("user/a/wvideo/getQRCode.do?width=400&height=400&text=asjdoiasjfiuahf",).body					

						#puts image.class

						# connection = Faraday.new( :url => "https://qyapi.weixin.qq.com/" )
						# response = connection.post("cgi-bin/media/upload?access_token="+ access_token + "&type=image", {:media => image }).body

						#url = URI.parse('https://qyapi.weixin.qq.com/cgi-bin/media/upload?access_token='+ access_token + '&type=image')

						#connection = Faraday.new( :url => "https://qyapi.weixin.qq.com/" )
						#response = connection.post("cgi-bin/media/get?access_token="+ access_token + "&media_id=" + "1r6dxwlJMWepFNvbQt983z5pmK-_9p1jMQUW6zyuz-u3XDR0hjv5tioP2rxqmrlqjVZSgMA-hWPARuH3XduBG2g",).body	

						#render :text => response
						msg = "1r6dxwlJMWepFNvbQt983z5pmK-_9p1jMQUW6zyuz-u3XDR0hjv5tioP2rxqmrlqjVZSgMA-hWPARuH3XduBG2g"

					end

					
			 
				elsif content["MsgType"] == "text"
					
					if content["Content"].size == 18				

						connection = Faraday.new( :url => "http://www.showks.cn:15577/" )
						response = connection.post("accounts/bind_weixin", { :id_card => content["Content"], :weixinID => content["FromUserName"] } ).body	

						msg = "绑定成功" if response.to_i == 200
						msg = "错误的身份证信息" if response.to_i == 404

						msgtype = "text"
					end
				end

				if msgtype == "text"
				json = {
					:touser => content["FromUserName"],
					:msgtype => "text",
					:agentid => 3,
					:text => {
						:content => msg
						}
					}
				else
					json = {
					:touser => content["FromUserName"],
					:msgtype => "image",
					:agentid => 3,
					:image => {
						:media_id => msg
						}
					}
				end	


					json = JSON.generate(json.as_json)

					connection = Faraday.new( :url => "https://qyapi.weixin.qq.com/" )
					response = connection.post("cgi-bin/message/send?access_token="+ access_token, json).body					


				render :text => response
			end
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
