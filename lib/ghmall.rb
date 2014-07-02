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
    def get_mem_by_card_num(card_num, terminal_id)
      request("findMemberByCardNo.action", "&cardNo=#{card_num}&deviceName=#{terminal_id}&actionType=0")
    end

    # 根据手机号获取会员信息
    def get_mem_by_phone_num(phone, terminal_id)
      request("getMemberByPhone.action", "&phone=#{phone}&deviceName=#{terminal_id}&actionType=0")
    end

    # 根据开始日期和截止日期获取消费记录
    def get_consumer_record_by_date_zone(params_hash)
      request("listTrades.action", "&cardNo=#{params_hash[:card_num]}&tradeVO.beginDate=#{params_hash[:start_date]}&tradeVO.endDate=#{params_hash[:end_date]}&deviceName=#{params_hash[:terminal_id]}&actionType=1")
    end

    # 根据开始日期和截止日期获取积分记录
    def get_credits_record_by_date_zone(params_hash)
      request("listIntegrals.action", "&cardNo=#{params_hash[:card_num]}&integralVO.beginDate=#{params_hash[:start_date]}&integralVO.endDate=#{params_hash[:end_date]}&deviceName=#{params_hash[:terminal_id]}&actionType=2")
    end

    # 根据开始日期和截止日期获取停车记录
    def get_parking_record(params_hash)
      request("listParkings.action", "&cardNo=#{params_hash[:card_num]}&parkingVO.beginDate=#{params_hash[:start_date]}&parkingVO.endDate=#{params_hash[:end_date]}&deviceName=#{params_hash[:terminal_id]}")
    end

    # 根据会员卡号获取可用积分兑换的礼品
    def get_gifts(card_num, terminal_id)
      request("listGifts.action", "&cardNo=#{card_num}")
    end

    # 礼品兑换
    def exhange_gift(params_hash)
      request("exchangeGift.action", "&cardNo=#{params_hash[:card_num]}&giftID=#{params_hash[:gift_id]}&deviceName=#{params_hash[:terminal_id]}&actionType=7")
    end

    # 每日签到
    def sign_in_daily(card_num, terminal_id)
      request("signIn.action", "&cardNo=#{card_num}&deviceName=#{terminal_id}&actionType=5")
    end
  end
end
