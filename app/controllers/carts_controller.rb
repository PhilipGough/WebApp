class CartsController < ApplicationController

  def show
    if  current_user.nil?
      redirect_to noaccess_path
    else 
      cart_ids = $redis.smembers current_user_cart
      if ! cart_ids.empty?
        @products = Product.find(cart_ids)
      else
        flash[:danger] = "Your cart is empty!"
        redirect_to products_path 
      end  
    end
  end  


  def add
    $redis.sadd current_user_cart, params[:product_id]
    redirect_to products_path
  end

  def remove
    $redis.srem current_user_cart, params[:product_id]
    redirect_to products_path
  end

  private

  def current_user_cart
    "cart#{current_user.id}"
  end

  
end