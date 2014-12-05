class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.decimal :cost
      t.decimal :shipping
      t.decimal :total
      t.boolean :shipped , default: false
      t.integer :user_id
      t.integer :billing_address_id
      t.integer :shipping_address_id
      t.timestamps
    end
  end
end
