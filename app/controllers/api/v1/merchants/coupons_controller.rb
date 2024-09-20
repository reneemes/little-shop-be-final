class Api::V1::Merchants::CouponsController < ApplicationController

  def index
    merchant = Merchant.find(params[:merchant_id])
    coupons = merchant.coupons
    render json: CouponSerializer.new(coupons)
  end

  def show
    coupon = Coupon.find(params[:id])
    # coupon = merchant.coupons.find(params[:id]) #Ensures the coupon belongs to the merchant
    render json: CouponSerializer.new(coupon, { params: { include_usage: true } })#.serializable_hash
  end
end