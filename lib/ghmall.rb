require "ghmall/version"
require 'open-uri'

module Ghmall
  class Info
    BaseUrl = "http://api2.rongyi.com/rongyi-api/api/ncplaza/"

    def initialize(token)
      @token = token
    end

    def request(action, params_str)
      url = "#{BaseUrl}#{action}?token=#{@token}#{params_str}"
      JSON.parse(open(url).read)
    end

    # 根据会员卡号获取会员信息
    def get_mem_by_card_num(card_num)
      request("findMemberByCardNo.action", "&cardNo=#{card_num}")
    end

    # 根据手机号获取会员信息
    def get_mem_by_phone_num(phone)
      request("getMemberByPhone.action", "&phone=#{phone}")
    end

    # 根据开始日期和截止日期获取消费记录
    def get_consumer_record_by_date_zone(params_hash)
      request("listTrades.action", "&cardNo=#{params_hash[:card_num]}&tradeVO.beginDate=#{params_hash[:start_date]}&tradeVO.endDate=#{params_hash[:end_date]}")
    end

    # 根据开始日期和截止日期获取积分记录
    def get_credits_record_by_date_zone(params_hash)
      request("listIntegrals.action", "&cardNo=#{params_hash[:card_num]}&integralVO.beginDate=#{params_hash[:start_date]}&integralVO.endDate=#{params_hash[:end_date]}")
    end

    # 根据开始日期和截止日期获取停车记录
    def get_parking_record(params_hash)
      request("listParkings.action", "&cardNo=#{params_hash[:card_num]}&parkingVO.beginDate=#{params_hash[:start_date]}&parkingVO.endDate=#{params_hash[:end_date]}")
    end

    # 根据会员卡号获取可用积分兑换的礼品
    def get_gifts(card_num)
      request("listGifts.action", "&cardNo=#{card_num}")
    end

    # 礼品兑换
    def exhange_gift(params_hash)
      request("exchangeGift.action", "&cardNo=#{params_hash[:card_num]}&giftID=#{params_hash[:gift_id]}")
    end
  end
end
