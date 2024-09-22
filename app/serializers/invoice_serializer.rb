class InvoiceSerializer
  include JSONAPI::Serializer
  attributes :merchant_id, :customer_id, :status
   
  attributes :coupon_id, if: Proc.new { |coupon, params| params[:include_coupon_id] } do |coupon|
    coupon.id
  end
end