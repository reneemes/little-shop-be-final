class Api::V1::Merchants::CouponsController < ApplicationController

  def index
    merchant = Merchant.find(params[:merchant_id])
    coupons = merchant.coupons
    render json: CouponSerializer.new(coupons, meta: { count: coupons.count })
  end

  def show
    coupon = Coupon.find(params[:id])
    # coupon = merchant.coupons.find(params[:id]) #Ensures the coupon belongs to the merchant
    render json: CouponSerializer.new(coupon, { params: { include_usage: true } })
  end

  def create
    merchant = Merchant.find(params[:merchant_id])
    new_coupon = merchant.coupons.new(coupon_params)
    if new_coupon.save
      render json: CouponSerializer.new(new_coupon), status: :created
    else
      render json: ErrorSerializer.creation_error("Creation failed"), status: :unprocessable_entity
    end
  rescue ActionController::ParameterMissing => error
    render json: { message: "Missing parameters", errors: [error.message] }, status: :unprocessable_entity
  end

  def update
    coupon = Coupon.find(params[:id])
    updated_coupon = coupon.update(toggle_status)
    render json: CouponSerializer.new(updated_coupon), status: :ok
  end

  private

  def coupon_params
    params.require(:coupon).permit(:name, :discount, :code)
  end

  def toggle_status
    status: !coupon.status
  end
end