module ProductsHelper

  def has_img?(product)
      product.avatar_file_name?
  end

  def low_stock?(product)
      product.quantity <= 5
  end 

  def in_stock?(product)
      product.quantity > 0
  end  


end
