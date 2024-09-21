class InvoiceSerializer
  include JSONAPI::Serializer
  attributes :merchant_id, :customer_id, :status
   
  attributes :coupon_id, if: Proc.new { |invoice, params| params[:include_coupon_id] } do |invoice|
    require 'pry'; binding.pry
  end
end