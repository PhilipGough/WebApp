class AddProductsToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :products, :text
  end
end
