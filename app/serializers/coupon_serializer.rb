class CouponSerializer
  include JSONAPI::Serializer
  attributes :name, :discount, :code, :merchant

  attribute :times_used, if: Proc.new { |coupon, params| params[:include_usage] } do |coupon|
    # require 'pry'; binding.pry
    coupon.invoices.count
  end
end
