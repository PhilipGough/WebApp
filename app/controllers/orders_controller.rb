class OrdersController < ApplicationController

    def index
     end   

    def new
        session[:billing_address_id] = params[:value]
        @order = Order.new
        @shipping = Address.find(session[:shipping_address_id])
        @billing = Address.find(session[:billing_address_id])
        @products = cart_contents
       
    end

    def shipping

        @saved_add = current_user.addresses
        @address = Address.new

    end  

    def billing
        session[:shipping_address_id] = params[:value]
        @saved_add = current_user.addresses
        @address = Address.new
     
    end  


    def create
        @order = current_user.orders.build(order_params)
        if @order.save
                @order.total = order_total 
                @order.shipping = shipping_cost
                @order.cost = cart_val
                @order.adjust_product_line 
                @order.save
                reset_cart
                del_cart_key
                redirect_to root_path
                
        else
            
            raise "error"
        end    

    end

    private
    def order_params
        params.fetch(:order, {}).permit(:total, :shipping,
         :cost).merge(:products => cart_contents,
            :billing_address_id => session[:billing_address_id],
                        :shipping_address_id => session[:shipping_address_id])
    end 


end
