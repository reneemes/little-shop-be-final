class Invoice < ApplicationRecord
  belongs_to :customer
  belongs_to :merchant
  belongs_to :coupon, optional: true
  has_many :invoice_items, dependent: :destroy
  has_many :transactions, dependent: :destroy

  validates :status, inclusion: { in: ["shipped", "packaged", "returned"] }

  after_save :calculate_invoice_coupon_count

  # def handle_percentage_or_dollar_off
  #   if !coupon.present?
  #     invoice_total
  #   elsif coupon.present? && coupon.discount >= 0.00
  #     calculate_percentage_off
  #   elsif coupon.present? && coupon.discount <= 0.00
  #     calculate_dollar_off
  #   end
  # end

  # def calculate_dollar_off
  #   total = invoice_total
  #   total_with_discount = total + coupon.discount
  #   if total_with_discount > 0.00
  #     return total_with_discount
  #   elsif total_with_discount < 0.00
  #     return 0.00
  #   end
  # end

  # def calculate_percentage_off
  #     total = invoice_total
  #     discount = coupon.discount / 100.00
  #     total -= total * discount
  #     total
  # end

  # def invoice_total
  #   total = 0
  #   self.invoice_items.each do |item|
  #     total += item.unit_price
  #   end
  #   return total
  # end

  private

  def calculate_invoice_coupon_count
    count = merchant.invoices.where.not(coupon_id: nil).count
    merchant.update(invoice_coupon_count: count)
  end
end