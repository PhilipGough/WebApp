module ProductsHelper

    def has_img?(product)
      product.avatar_file_name?
  end

  def low_stock?(product)
      product.quantity <= 6
  end  

end