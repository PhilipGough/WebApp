class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.string :fullname
      t.string :lineone
      t.string :linetwo
      t.string :city
      t.string :state
      t.string :zip
      t.string :country
      t.string :phone
      t.integer :user_id

      t.timestamps
    end
  end
end
