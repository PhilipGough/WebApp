class AddressesController < ApplicationController
  before_action :logged_in_user, only: [:create,:edit, :update,:destroy]

 def edit
    @address = Address.find(params[:id])
 end


 def create
     if current_user.addresses.size < 4
        @address = current_user.addresses.create(address_params)
        if @address.save
            flash[:success] = "Address saved"
            redirect_to :back
        else
            flash[:danger] = "Missing details"
            redirect_to :back
        end    
    else
        flash[:danger] = "You cannot have more than 4 saved addresses"
        redirect_to :back
    end        
 end

   def update
    @address = Address.find(params[:id])
    if @address.update_attributes(address_params)
      flash[:success] = "Address updated"
      redirect_to cart_path
    else
      render 'edit'
    end
  end 

  def index
    if logged_in?
      @addresses = current_user.addresses
    else
      flash[:danger] = "You must log in to view your saved addresses" 
      redirect_to noaccess_path
    end   
  end  


  def show
    if logged_in?
      @address = Address.find(params[:id])
    else
      flash[:danger] = "You do not have permission to access this content" 
      redirect_to noaccess_path
    end     
  end 


   def destroy
    Address.find(params[:id]).destroy
    flash[:success] = "This Address has been deleted"
    redirect_to addresses_path
  end

    private
      def address_params
        params.require(:address).permit(:fullname, :lineone, :linetwo,
            :city, :country , :phone)
      end 

    private 
     def logged_in_user
        if not logged_in?
            flash[:danger] = "You do not have permission to access this content" 
            redirect_to noaccess_path
        end    
    end   
end
