class Api::V1::Merchants::CouponsController < ApplicationController

  def index
    merchant = Merchant.find(params[:merchant_id])
    # require 'pry'; binding.pry
    coupons = merchant.coupons
    render json: CouponSerializer.new(coupons)
  end
end