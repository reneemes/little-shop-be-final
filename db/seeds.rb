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

Coupon.create!(name: "Five Dollars Off", merchant_id: 1, code: "SAVE5", discount: -5.00)
Coupon.create!(name: "Twenty Dollars Off", merchant_id: 1, code: "SAVE20", discount: -20.00)


Coupon.create!(name: "Chopper's Chopped Deals", merchant_id: 2, code: "DOCTOR", discount: 50.00)
Coupon.create!(name: "Sanji's Savings", merchant_id: 2, code: "COOK", discount: -10.00)
Coupon.create!(name: "Zoro's Slashed Savings", merchant_id: 2, code: "NAPTIME", discount: 25.00)
Coupon.create!(name: "Franky's Auto Repairs", merchant_id: 2, code: "SUUUPER", discount: -100.00)
Coupon.create!(name: "Robin's Book Deals", merchant_id: 2, code: "BLOOMBLOOM", discount: 75.00)