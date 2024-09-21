require 'rails_helper'

RSpec.describe "Coupons Controller" do
  # let(:merchant) { create(:merchant) }
  # let(:coupon) { build(:coupon, merchant: merchant) }

  before (:each) do
    @merchant1 = Merchant.create!(name: "Kozey Group")
    @merchant2 = Merchant.create!(name: "THEE One Piece Shop")

    @coupon1 = Coupon.create!(name: "Five Dollars Off", merchant_id: @merchant1.id, code: "SAVE5", discount: -5.00)
    @coupon2 = Coupon.create!(name: "Twenty Dollars Off", merchant_id: @merchant1.id, code: "SAVE20", discount: -20.00)
    
    @op_coupon1 = Coupon.create!(name: "Chopper's Chopped Deals", merchant_id: @merchant2.id, code: "DOCTOR", discount: 50.00)
    @op_coupon2 = Coupon.create!(name: "Sanji's Savings", merchant_id: @merchant2.id, code: "COOK", discount: -10.00)
    @op_coupon3 = Coupon.create!(name: "Zoro's Slashed Savings", merchant_id: @merchant2.id, code: "NAPTIME", discount: 25.00)
    @op_coupon4 = Coupon.create!(name: "Franky's Auto Repairs", merchant_id: @merchant2.id, code: "SUUUPER", discount: -100.00)
    @op_coupon5 = Coupon.create!(name: "Robin's Book Deals", merchant_id: @merchant2.id, code: "BLOOMBLOOM", discount: 75.00)
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

  describe 'Show Action' do
    it 'can return an item by ID for a specific merchant' do
      get "/api/v1/merchants/#{@merchant1.id}/coupons/#{@coupon1.id}"

      expect(response).to be_successful
      expect(response.status).to eq(200)

      data = JSON.parse(response.body, symbolize_names: true)[:data]
    
      data = data[:attributes]
      expect(data[:times_used]).to be_present
      expect(data[:times_used]).to eq(0)
    end
  end

  describe 'Create Action' do
    it 'can create a coupon for a specific merchant' do
      coupon_params = {
        "name": "Ten Percent Off",
        "discount": 10.00,
        "code": "SAVE10"
      }
      post "/api/v1/merchants/#{@merchant1.id}/coupons", params: coupon_params, as: :json
      data = JSON.parse(response.body, symbolize_names: true)[:data][:attributes]
    
      expect(response).to be_successful
      expect(response.status).to eq(201)
      expect(response).to have_http_status(:created)

      expect(data[:name]).to eq("Ten Percent Off")
      expect(data[:merchant][:id]).to eq(@merchant1.id)
    end

    it 'handles merchants that already have 5 coupons' do
      sixth_coupon = {
        "name": "Ten Percent Off",
        "discount": 10.00,
        "code": "SAVE10"
      }
      post "/api/v1/merchants/#{@merchant2.id}/coupons", params: sixth_coupon, as: :json
      data = JSON.parse(response.body, symbolize_names: true)
      expect(response).to_not be_successful
      expect(data[:message]).to eq("Creation failed")
      expect(data[:errors]).to eq(["param is missing or the value is empty: coupon"])
    end

    it 'handles coupon codes that are not unique' do
      coupon1_code_copy = Coupon.create(
      name: "Five Percent Off",
      merchant_id: @merchant1.id,
      code: "SAVE5",
      discount: 5.00)

      post "/api/v1/merchants/#{@merchant1.id}/coupons", params: coupon1_code_copy, as: :json
      data = JSON.parse(response.body, symbolize_names: true)
      
      expect(response).to_not be_successful
      expect(data[:message]).to eq("Creation failed")
      expect(data[:errors]).to eq(["param is missing or the value is empty: coupon"])
    end

    it 'handles no parameters' do
      invalid_params = { }
      post "/api/v1/merchants/#{@merchant1.id}/coupons", params: invalid_params, as: :json
      data = JSON.parse(response.body, symbolize_names: true)

      expect(response).to_not be_successful
      expect(response.status).to eq(422)

      expect(data[:message]).to eq("Missing parameters")
      expect(data[:errors]).to eq(["param is missing or the value is empty: coupon"])
    end

    it 'handles missing parameters' do
      invalid_params = {
        "name": "Half-baked Coupon",
        "discount": 50.00
      }
      post "/api/v1/merchants/#{@merchant1.id}/coupons", params: invalid_params, as: :json
      data = JSON.parse(response.body, symbolize_names: true)

      expect(response).to_not be_successful
      expect(response.status).to eq(422)

      expect(data[:message]).to eq("Creation failed")
      expect(data[:errors]).to eq(["param is missing or the value is empty: coupon"])
    end
  end
end