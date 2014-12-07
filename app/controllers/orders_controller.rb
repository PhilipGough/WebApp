class OrdersController < ApplicationController
    before_action :logged_in_user, only: [:create,:show,:index,:update]


    def index
        if params[:name] == "admin" && current_user.admin?
            @orders = Order.all  

        elsif params[:name] == "unshipped" && current_user.admin? 
            @orders = Order.unshipped

        elsif params[:name] == "weekly" && current_user.admin?
            @orders = Order.weekly_orders   

        else 
            @orders = current_user.orders
        end 
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
            #debug
            raise "error"
        end    

    end

    def update
        if current_user.admin?
           @order = Order.find_by_id(params[:id]) 
           @order.shipped = true 
           @order.save
           redirect_to :back
        end   
    end    



    private
    def order_params
        params.fetch(:order, {}).permit(:total, :shipping,
           :cost).merge(:products => cart_contents,
           :billing_address_id => session[:billing_address_id],
           :shipping_address_id => session[:shipping_address_id])
       end 

       private 
       def logged_in_user
        if not logged_in?
            flash[:danger] = "You do not have permission to access this content" 
            redirect_to noaccess_path
        end    
    end    


end
