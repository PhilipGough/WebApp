class ProductsController < ApplicationController
  before_action :has_permissions, only: [:edit, :update, :destroy]

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
  end

  def edit
    @product = Product.find(params[:id])
  end

  def destroy
  end

  def index
    @products = Product.all
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
          redirect_to root_url
        end
      end