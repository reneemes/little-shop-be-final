require "rails_helper"

RSpec.describe Invoice do
  it { should belong_to :merchant }
  it { should belong_to :customer }
  it { should validate_inclusion_of(:status).in_array(%w(shipped packaged returned)) }

  describe 'Invoice Total' do
    it 'can calculate the total of the invoice items' do
      merchant = Merchant.create!(name: "Tom Nook")
      customer = Customer.create!(first_name: "Island", last_name: "Rep")
      item1 = Item.create!(name: "Fishing Rod", description: "Great for catching fish!", unit_price: 500.00, merchant_id: merchant.id)
      item2 = Item.create!(name: "Shovel", description: "Great for finding buried treasure!", unit_price: 500.00, merchant_id: merchant.id)
      invoice = Invoice.create!(merchant_id: merchant.id, customer_id: customer.id, status: "packaged")
      invoice_item = InvoiceItem.create!(invoice_id: invoice.id, item_id: item1.id, quantity: 1, unit_price: 500.00)
      invoice_item = InvoiceItem.create!(invoice_id: invoice.id, item_id: item2.id, quantity: 1, unit_price: 500.00)

      total = invoice.invoice_total
      expect(total).to eq(1000.00)
    end
  end

  describe 'Percentage Off' do
    xit 'can take the coupon discount off the invoice total' do
      # discount = Invoice.percentage_off
    end
  end
end