class Coupon < ApplicationRecord
  belongs_to :merchant
  has_many :invoices

  # validates :name, presence: true
  # validates :discount, presence: true
  validates :code, uniqueness: true
  validates :name, :discount, :code, presence: true

  # before_create :check_count
  # validate :check_count
  validate :check_count, on: :create

  private

  def check_count
    # require 'pry'; binding.pry
    if merchant && merchant.coupons.count >= 5
      errors.add :base, message: "Merchant already has 5 coupons"
      # return false
    end
  end
end