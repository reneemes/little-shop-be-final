class Coupon < ApplicationRecord
  belongs_to :merchant, counter_cache: :coupons_count
  has_many :invoices

  validates :name, :discount, :code, presence: true
  validates :code, uniqueness: true

  validate :check_count, on: :create
  validate :deactivation_valid?, on: :update

  def toggle_status
    update(active: !active)
  end

  def self.sort_by_status(status)
    coupons = all
    coupons = sorted_coupons(coupons, status)
  end

  private

  def check_count
    if merchant && merchant.coupons.count >= 5
      errors.add :base, message: "Merchant already has 5 coupons"
    end
  end

  def deactivation_valid?
    if !active && invoices.present?
      errors.add :base, message: "Cannot deactivate coupon while applied to an invoice"
    end
  end

  def self.sorted_coupons(coupons, status)
    if status == "active"
      coupons = coupons.where(active: true)
    elsif status == "inactive"
      coupons = coupons.where(active: false)
    end
    coupons
  end
end