#encoding: utf-8
class PKCS7Encoder < ActiveRecord::Base
  # attr_accessible :title, :body

  def self.decode(text)
    pad = text[-1].ord
    pad = 0 if (pad < 1 || pad > 32)
    size = text.size - pad
    text[0...size]
  end

  # 对需要加密的明文进行填充补位
  # 返回补齐明文字符串
  def self.encode(text)
    # 计算需要填充的位数
    amount_to_pad = 32 - (text.length % 32)
    amount_to_pad = 32 if amount_to_pad == 0
    # 获得补位所用的字符
    pad_chr = amount_to_pad.chr
    "#{text}#{pad_chr * amount_to_pad}"
  end

end
