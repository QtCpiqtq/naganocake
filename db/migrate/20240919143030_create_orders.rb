class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.integer :customer_id, null: false
      t.datetime :date, null: false
      t.string :postal_code, null: false
      t.string :address, null: false
      t.string :name, null: false
      t.integer :payment_method, null: false
      t.integer :price, null: false
      t.integer :shipping_fee, null: false
      t.integer :sutasus, null: false, default: "0"

      t.timestamps
    end
  end
end
