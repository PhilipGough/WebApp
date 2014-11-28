class DeleteStringFromProducts < ActiveRecord::Migration
  def change
    remove_column :products, :string
  end
end
