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
    if missing_params?
      missing_params_response
      return
    end

    merchant = Merchant.find(params[:merchant_id])
    new_coupon = merchant.coupons.new(coupon_params)

    if new_coupon.save
      render json: CouponSerializer.new(new_coupon), status: :created
    else
      render json: ErrorSerializer.creation_error(new_coupon.errors.full_messages), status: :unprocessable_entity
    end
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

  def missing_params?
    params[:coupon].blank?
  end

  def missing_params_response
    render json: ErrorSerializer.creation_error(["Missing parameters"]), status: :bad_request
  end
end
