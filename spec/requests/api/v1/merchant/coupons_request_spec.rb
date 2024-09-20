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

  describe 'Show Action' do
    it 'can return an item by ID for a specific merchant' do
      get "/api/v1/merchants/#{@merchant1.id}/coupons/#{@coupon1.id}"

      expect(response).to be_successful
      expect(response.status).to eq(200)

      data = JSON.parse(response.body, symbolize_names: true)[:data]
      # require 'pry'; binding.pry
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

    end

    it 'handles coupon codes that are not unique' do

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