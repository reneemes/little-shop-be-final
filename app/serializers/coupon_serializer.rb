class CouponSerializer
  include JSONAPI::Serializer
  attributes :name, :discount, :code, :merchant
end
