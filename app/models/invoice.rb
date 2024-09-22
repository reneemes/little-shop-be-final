class Invoice < ApplicationRecord
  belongs_to :customer
  belongs_to :merchant
  belongs_to :coupon, optional: true
  has_many :invoice_items, dependent: :destroy
  has_many :transactions, dependent: :destroy

  validates :status, inclusion: { in: ["shipped", "packaged", "returned"] }

  def calculate_percentage_off
    if !coupon.present?
      return invoice_total
    elsif coupon.present?
      total = invoice_total
      discount = coupon.discount / 100.00
      total -= total * discount
      return total
    end
  end

  def invoice_total
    total = 0
    self.invoice_items.each do |item|
      total += item.unit_price
    end
    return total
  end
end