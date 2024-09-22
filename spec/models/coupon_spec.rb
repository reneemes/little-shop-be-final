require "rails_helper"

RSpec.describe Coupon do
  before (:each) do
    @merchant2 = Merchant.create!(name: "THEE One Piece Shop")
    @customer = Customer.create!(first_name: "Boa", last_name: "Hancock")
    @op_coupon1 = Coupon.create!(name: "Chopper's Chopped Deals", merchant_id: @merchant2.id, code: "DOCTOR", discount: 50.00)
    @op_coupon2 = Coupon.create!(name: "Sanji's Savings", merchant_id: @merchant2.id, code: "COOK", discount: 10.00)
    @op_coupon3 = Coupon.create!(name: "Zoro's Slashed Savings", merchant_id: @merchant2.id, code: "NAPTIME", discount: 25.00)
    @op_coupon4 = Coupon.create!(name: "Franky's Auto Repairs", merchant_id: @merchant2.id, code: "SUUUPER", discount: 100.00)
    @op_coupon5 = Coupon.create!(name: "Robin's Book Deals", merchant_id: @merchant2.id, code: "BLOOMBLOOM", discount: 75.00)
  end

  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :discount }
    it { should validate_presence_of :code }
  end

  describe 'relationships' do
    it { should belong_to :merchant }
    it { should have_many :invoices }
  end

  describe 'check_count' do
    it 'checks the current coupon count before creation' do
      expect(@merchant2.coupons.count).to eq(5)
      sixth_coupon = Coupon.create(
        name: "Ten Percent Off",
        merchant_id: @merchant2.id,
        discount: 10.00,
        code: "SAVE10"
      )
      expect(@merchant2.coupons.count).to eq(5)
      expect(sixth_coupon.valid?).to eq(false)
      expect(sixth_coupon.errors[:base]).to eq(["Merchant already has 5 coupons"])
    end
  end

  describe 'toggle_status' do
    it 'can change active status true/false' do
      expect(@op_coupon2.active).to eq(true)
      @op_coupon2.toggle_status
      expect(@op_coupon2.active).to eq(false)
    end
  end

  describe 'deactivation_valid?' do
    it 'checks if the coupon is on an invoice before deactivation' do
      expect(@op_coupon1.active).to eq(true)
      invoice = Invoice.create!(merchant_id: @merchant2.id, customer_id: @customer.id, coupon_id: @op_coupon1.id, status: "packaged")
      @op_coupon1.toggle_status
      expect(@op_coupon1.reload.active).to eq(true)
    end
  end
end