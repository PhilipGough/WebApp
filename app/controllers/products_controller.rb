class ProductsController < ApplicationController
  before_action :has_permissions, only: [:create, :edit, :update, :destroy]

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      flash[:success] = "Product added"
      redirect_to root_path
    else
     flash[:danger] = "Missing Details"
     redirect_to  :action => :new
   end

 end

 def update
  @product = Product.find(params[:id])
  if @product.update_attributes(product_params)
    flash[:success] = "Product updated"
    redirect_to products_path
  else
    render 'edit'
  end    
end

def edit
  @product = Product.find(params[:id])
end


def destroy
  Product.find(params[:id]).destroy
  flash[:success] = "This product has been deleted"
  redirect_to products_path
end

def index
  if ! current_user.nil?
    @products = Product.all
  else
    redirect_to noaccess_path
  end  
end

def show
  @product = Product.find(params[:id])
end
end

private

def product_params
  params.require(:product).permit(:title, :description,
   :price,:avatar,:avatar_file_name,:quantity)
end 


private
def has_permissions
  unless is_admin?
    flash[:danger] = "You do not have required permissions! "
    redirect_to  noaccess_path
  end
end