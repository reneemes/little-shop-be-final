require "rails_helper"

RSpec.describe Coupon do
  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :discount }
    it { should validate_presence_of :code }

    # it { should validate_presence_of :coupon_limit}
  end

  describe 'relationships' do
    it { should belong_to :merchant }
    it { should have_many :invoices }
  end
end