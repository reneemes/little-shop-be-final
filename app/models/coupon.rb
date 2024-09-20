class Coupon < ApplicationRecord
  belongs_to :merchant
  has_many :invoices

  # validates :name, presence: true
  # validates :discount, presence: true
  # validates :code, presence: true
  validates :name, :discount, :code, presence: true

  # validate :coupon_limit, on: :create

  # def coupon_limit
  #   if merchant.coupons.count >= 5
  #     # require 'pry'; binding.pry
  #   end
  # end
end