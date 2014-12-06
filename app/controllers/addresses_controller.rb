class AddressesController < ApplicationController

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


   def destroy
    Address.find(params[:id]).destroy
    flash[:success] = "This Address has been deleted"
    redirect_to cart_path
  end

    private
      def address_params
        params.require(:address).permit(:fullname, :lineone, :linetwo,
            :city, :country , :phone)
      end   
end
