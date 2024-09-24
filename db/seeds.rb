# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
cmd = "pg_restore --verbose --clean --no-acl --no-owner -h localhost -U $(whoami) -d little_shop_development db/data/little_shop_development.pgdump"
puts "Loading PostgreSQL Data dump into local database with command:"
puts cmd
system(cmd)

system("rails db:migrate")
# Merchants
merchant1 = Merchant.create!(name: "Going Merry")
merchant2 = Merchant.create!(name: "The Thousand Sunny")
merchant3 = Merchant.create!(name: "Polar Tang")
merchant4 = Merchant.create!(name: "The Oro Jackson")

# Merchant 1 Coupons
coupon1 = Coupon.create!(name: "Chopper's Chopped Deals", merchant_id: merchant1.id, code: "DOCTOR", discount: -50.00)
coupon2 = Coupon.create!(name: "Sanji's Savings", merchant_id: merchant1.id, code: "COOK", discount: -10.00)
coupon3 = Coupon.create!(name: "Zoro's Slashed Savings", merchant_id: merchant1.id, code: "NAPTIME", discount: 25.00)
coupon3 = Coupon.create!(name: "Franky's Auto Repairs", merchant_id: merchant1.id, code: "SUUUPER", discount: 70.00)
coupon5 = Coupon.create!(name: "Robin's Book Deals", merchant_id: merchant1.id, code: "BLOOM", discount: 75.00)

# Merchant 2 Coupons
coupon6 = Coupon.create!(name: "Five Percentage Off", merchant_id: merchant2.id, code: "SAVE5", discount: 5.00, active: false)
coupon7 = Coupon.create!(name: "Twenty Percent Off", merchant_id: merchant2.id, code: "SAVE20", discount: 20.00)

# Merchant 3 Coupons
coupon8 = Coupon.create!(name: "Luffy's Discount", merchant_id: merchant3.id, code: "GUMGUM", discount: 75.00)

# Merchant 4 Coupons
coupon9 = Coupon.create!(name: "Twenty Percent Off", merchant_id: merchant4.id, code: "SAVE20%", discount: 20.00)
coupon10 = Coupon.create!(name: "Twenty Dollars Off", merchant_id: merchant4.id, code: "SAVE$20", discount: -20.00)

# Customer
customer = Customer.create!(first_name: "Boa", last_name: "Hancock")

# Item
item = Item.create!(name: "Fishing Rod", description: "Great for catching fish!", unit_price: 500.00, merchant_id: merchant3.id)

# Invoice
invoice = Invoice.create!(merchant_id: merchant3.id, customer_id: customer.id, status: "shipped", coupon_id: coupon8.id)
invoice_item = InvoiceItem.create!(invoice_id: invoice.id, item_id: item.id, quantity: 1, unit_price: 500.00)

puts "Seed data created successfully."