class CreateCoupons < ActiveRecord::Migration[7.1]
  def change
    create_table :coupons do |t|
      t.string :name
      t.references :merchant, null: false, foreign_key: true
      t.string :code
      t.float :discount

      t.timestamps
    end
  end
end
