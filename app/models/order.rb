require 'product'
class Order < ActiveRecord::Base


    serialize :products, Array

    scope :unshipped, -> { where(shipped: false) }
    scope :weekly_orders, lambda { where(:created_at => (Time.now - 7.days)..Time.now) }
    
    belongs_to :user
    has_one :billing_address, :class_name => "Address",
    :foreign_key => "billing_address_id"
    has_one :shipping_address, :class_name => "Address",
    :foreign_key => "shipping_address_id"


    accepts_nested_attributes_for :billing_address , :shipping_address
    
    validates :user_id,  presence: true
    validates :billing_address_id,  presence: true
    validates :shipping_address_id,  presence: true



    def adjust_product_line
        products.each do |product|
            product.item_sold
        end    
    end 

end
