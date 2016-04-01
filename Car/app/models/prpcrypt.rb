#encoding: utf-8
class Prpcrypt < ActiveRecord::Base

	def self.decrypt(aes_key, text, corpid)
    status = 200
    text        = Base64.decode64(text)
    text        = handle_cipher(:decrypt, aes_key, text)
    result      = PKCS7Encoder.decode(text)
    content     = result[16...result.length]
    len_list    = content[0...4].unpack("N")
    xml_len     = len_list[0]
    xml_content = content[4...4 + xml_len]
    from_corpid = content[xml_len+4...content.size]
    # TODO: refactor

    if corpid != from_corpid
      Rails.logger.debug("#{__FILE__}:#{__LINE__} Failure because #{corpid} != #{from_corpid}")
      status = 401
    end
    [xml_content, status]
  end

  # 加密
  def self.encrypt(aes_key, text, corpid)
    text    = text.force_encoding("ASCII-8BIT")
    random  = SecureRandom.hex(8)
    msg_len = [text.length].pack("N")
    text    = "#{random}#{msg_len}#{text}#{corpid}"
    text    = PKCS7Encoder.encode(text)
    text    = handle_cipher(:encrypt, aes_key, text)
    Base64.encode64(text)
  end

#官方文档说明参考：AESKey=Base64_Decode(EncodingAESKey + “=”)，是AES算法的密钥，长度为32字节。AES采用CBC模式，数据采用PKCS#7填充；IV初始向量大小为16字节，取AESKey前16字节
  private
    def self.handle_cipher(action, aes_key, text)
      cipher = OpenSSL::Cipher.new('AES-256-CBC')
      cipher.send(action)
      cipher.padding = 0
      cipher.key     = aes_key
      cipher.iv      = aes_key[0...16]
      cipher.update(text) + cipher.final
    end
end
