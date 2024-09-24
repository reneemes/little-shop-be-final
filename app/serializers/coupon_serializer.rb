class CouponSerializer
  include JSONAPI::Serializer
  attributes :id, :name, :discount, :code, :merchant, :active

  attribute :times_used, if: Proc.new { |coupon, params| params[:include_usage] } do |coupon|
    coupon.invoices.count
  end
end
