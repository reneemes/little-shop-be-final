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

  def create
    merchant = Merchant.find(params[:merchant_id])
    # require 'pry'; binding.pry
    new_coupon = merchant.coupons.new(coupon_params)
    if new_coupon.save
      render json: CouponSerializer.new(new_coupon), status: :created
    else
      render json: ErrorSerializer.creation_error("Creation failed"), status: :unprocessable_entity
    end
  rescue ActionController::ParameterMissing => error
    render json: { message: "Missing parameters", errors: [error.message] }, status: :unprocessable_entity
  end

  private

  def coupon_params
    params.require(:coupon).permit(:name, :discount, :code)
  end
end