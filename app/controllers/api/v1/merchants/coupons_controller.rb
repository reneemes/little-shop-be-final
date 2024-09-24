class Api::V1::Merchants::CouponsController < ApplicationController

  def index
    merchant = Merchant.find(params[:merchant_id])
    coupons = merchant.coupons.sort_by_status(params[:status])
    render json: CouponSerializer.new(coupons, meta: { count: coupons.count })
  end

  def show
    coupon = Coupon.find(params[:id])
    render json: CouponSerializer.new(coupon, { params: { include_usage: true } })
  end

  def create
    merchant = Merchant.find(params[:merchant_id])
    new_coupon = merchant.coupons.new(coupon_params)
    if new_coupon.save
      render json: CouponSerializer.new(new_coupon), status: :created
    else
      render json: ErrorSerializer.creation_error, status: :unprocessable_entity
    end
  rescue ActionController::ParameterMissing => error
    render json: { message: "Missing parameters", errors: [error.message] }, status: :unprocessable_entity
  end

  def update
    coupon = Coupon.find(params[:id])
    if coupon.toggle_status
      render json: CouponSerializer.new(coupon), status: :ok
    else
      render json: ErrorSerializer.active_status_error, status: :method_not_allowed
    end
  end

  private

  def coupon_params
    params.require(:coupon).permit(:name, :discount, :code)
  end
end
