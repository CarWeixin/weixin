#encoding: utf-8
#decoding: utf-8

class TokensController < ApplicationController
require 'base64'
require 'digest/sha1'
require 'nokogiri'

	def get
			sign = params[ :msg_signature]
			time = params[ :timestamp]
			nonce = params[ :nonce]
			echostr = params[ :echostr]

	 		token = "huyindianzikeji"

	 		key = "d2l1ZHczNDVqdXd1aWpzbmNoODc4d2tzamhpdXllc3I"

	 		corpID = "wx7ebbb056cec7e96d"

			aeskey = Base64.decode64( key + "=" )	 		

			if !echostr.nil?

		 		content, status = Prpcrypt.decrypt( aeskey , echostr, corpID ) 
				
				render :text => content
			else
				xml = params[ :xml]

				content, status = Prpcrypt.decrypt( aeskey , xml[ :Encrypt] , corpID)

				render :text => content
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
