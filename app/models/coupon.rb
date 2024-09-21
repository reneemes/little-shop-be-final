class Coupon < ApplicationRecord
  belongs_to :merchant
  has_many :invoices

  validates :name, :discount, :code, presence: true
  validates :code, uniqueness: true

  validate :check_count, on: :create

  private

  def check_count
    if merchant && merchant.coupons.count >= 5
      errors.add :base, message: "Merchant already has 5 coupons"
    end
  end
end