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


def cart_contents
    cart_ids = $redis.smembers current_user_cart
      if ! cart_ids.empty?
        @products = Product.find(cart_ids)
      else
        flash[:danger] = "Your cart is empty!"
        redirect_to products_path 
      end  
end


def current_user_cart
    "cart#{current_user.id}"
end


def del_cart_key
    $redis.DEL current_user_cart
end


def shipping_cost
    shipping = (BigDecimal.new(cart_total)/100)*10
end 


def order_total
     order = shipping_cost + (BigDecimal.new(cart_total))
end
 

def cart_val
    cost = (BigDecimal.new(cart_total))
end 
     
    

end
