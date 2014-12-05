class AddressesController < ApplicationController

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

    private
      def address_params
        params.require(:address).permit(:fullname, :lineone, :linetwo,
            :city, :country , :phone)
      end   
end
