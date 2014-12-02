module CartsHelper

 def reset_cart
   $redis.SET current_user_cart_total, 0
 end  

 def cart_cost (product_price)
  current_value = BigDecimal.new($redis.GET current_user_cart_total)
  puts "#{current_value}"
  updated_val = current_value + product_price
  $redis.SET current_user_cart_total, updated_val
  puts "#{updated_val}"
  updated_val
end 

def cart_total
  $redis.GET current_user_cart_total
end 

def current_user_cart_total
  "carttotal#{current_user.id}"
end 

def update_cart_count
    render json: current_user.cart_count, status: 200
end 

end
