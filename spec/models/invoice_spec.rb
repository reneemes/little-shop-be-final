require "rails_helper"

RSpec.describe Invoice do
  before (:each) do
    @merchant = Merchant.create!(name: "Tom Nook")
    @customer = Customer.create!(first_name: "Island", last_name: "Rep")
    @item1 = Item.create!(name: "Fishing Rod", description: "Great for catching fish!", unit_price: 500.00, merchant_id: @merchant.id)
    @item2 = Item.create!(name: "Shovel", description: "Great for finding buried treasure!", unit_price: 500.00, merchant_id: @merchant.id)
    @coupon = Coupon.create!(name: "Redd's Questionable Discounts", merchant_id: @merchant.id, code: "YESYES", discount: 15.00)
    @invoice = Invoice.create!(merchant_id: @merchant.id, customer_id: @customer.id, coupon_id: @coupon.id, status: "packaged")
    @invoice_item = InvoiceItem.create!(invoice_id: @invoice.id, item_id: @item1.id, quantity: 1, unit_price: 500.00)
    @invoice_item = InvoiceItem.create!(invoice_id: @invoice.id, item_id: @item2.id, quantity: 1, unit_price: 500.00)
  end

  it { should belong_to :merchant }
  it { should belong_to :customer }
  it { should belong_to(:coupon).optional }
  it { should validate_inclusion_of(:status).in_array(%w(shipped packaged returned)) }
  it { should have_many :invoice_items }
  it { should have_many :transactions }

  # describe 'calculate_invoice_coupon_count' do
  #   it 'can calculate the total amount of invoices with coupons applied to them' do
  #     coupon = Coupon.create!(name: "Redd's Questionable Discounts", merchant_id: @merchant.id, code: "SAVE100", discount: -1500.00)
  #     invoice = Invoice.create!(merchant_id: @merchant.id, customer_id: @customer.id, coupon_id: coupon.id, status: "packaged")
  #     invoice_item = InvoiceItem.create!(invoice_id: invoice.id, item_id: @item1.id, quantity: 1, unit_price: 500.00)
  #     invoice_item = InvoiceItem.create!(invoice_id: invoice.id, item_id: @item2.id, quantity: 1, unit_price: 500.00)

  #     count = invoice.calculate_invoice_coupon_count
  #     expect(count).to eq(1)
  #   end
  # end

  # describe 'Invoice Total' do
  #   it 'can calculate the total of the invoice items' do
  #     total = @invoice.invoice_total
  #     expect(total).to eq(1000.00)
  #   end
  # end
  
  # describe 'Calculate Percentage Off' do
  #   it 'can take the coupon discount off the invoice total' do
  #     total_with_coupon = @invoice.handle_percentage_or_dollar_off
  #     expect(total_with_coupon).to eq(850.00)
  #   end

  #   it 'can return the total without a coupon' do
  #   invoice = Invoice.create!(merchant_id: @merchant.id, customer_id: @customer.id, status: "packaged")
  #   invoice_item = InvoiceItem.create!(invoice_id: invoice.id, item_id: @item1.id, quantity: 1, unit_price: 500.00)
  #   invoice_item = InvoiceItem.create!(invoice_id: invoice.id, item_id: @item2.id, quantity: 1, unit_price: 500.00)

  #   total_without_coupon = invoice.handle_percentage_or_dollar_off
  #   expect(total_without_coupon).to eq(1000.00)
  #   end
  # end

  # describe 'handle_percentage_or_dollar_off' do
  #   it 'can determine if a coupon is a percentage of dollar discount' do
  #     coupon = Coupon.create!(name: "Redd's Questionable Discounts", merchant_id: @merchant.id, code: "SAVE100", discount: -100.00)
  #     invoice = Invoice.create!(merchant_id: @merchant.id, customer_id: @customer.id, coupon_id: coupon.id, status: "packaged")
  #     invoice_item = InvoiceItem.create!(invoice_id: invoice.id, item_id: @item1.id, quantity: 1, unit_price: 500.00)
  #     invoice_item = InvoiceItem.create!(invoice_id: invoice.id, item_id: @item2.id, quantity: 1, unit_price: 500.00)

  #     total_with_coupon = invoice.handle_percentage_or_dollar_off
  #     expect(total_with_coupon).to eq(900.00)
  #   end

  #   it 'handles negative values with the discount applied' do
  #     coupon = Coupon.create!(name: "Redd's Questionable Discounts", merchant_id: @merchant.id, code: "SAVE100", discount: -1500.00)
  #     invoice = Invoice.create!(merchant_id: @merchant.id, customer_id: @customer.id, coupon_id: coupon.id, status: "packaged")
  #     invoice_item = InvoiceItem.create!(invoice_id: invoice.id, item_id: @item1.id, quantity: 1, unit_price: 500.00)
  #     invoice_item = InvoiceItem.create!(invoice_id: invoice.id, item_id: @item2.id, quantity: 1, unit_price: 500.00)

  #     total_with_coupon = invoice.handle_percentage_or_dollar_off
  #     expect(total_with_coupon).to eq(0.00)
  #   end
  # end
end
