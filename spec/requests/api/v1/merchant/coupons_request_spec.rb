require 'rails_helper'

RSpec.describe "Coupons Controller" do
  before (:each) do
    @merchant1 = Merchant.create!(name: "Kozey Group")
    @coupon1 = Coupon.create!(
      name: "Five Dollars Off",
      merchant_id: @merchant1.id,
      code: "SAVE5",
      discount: -5.00)
    @coupon2 = Coupon.create!(name:
      "Twenty Dollars Off",
      merchant_id: @merchant1.id,
      code: "SAVE20",
      discount: -20.00)
  end

  describe 'Index Action' do
    it 'can show all coupons for one merchant' do
      get "/api/v1/merchants/#{@merchant1.id}/coupons"
      expect(response).to be_successful
      data = JSON.parse(response.body, symbolize_names: true)[:data]
      expect(data.count).to eq(2)
      data.each do |data|
        data = data[:attributes][:merchant]
        expect(data[:id]).to eq(@merchant1.id)
      end
    end
  end
end