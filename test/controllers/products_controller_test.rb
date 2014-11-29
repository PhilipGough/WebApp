require 'test_helper'

class ProductsControllerTest < ActionController::TestCase

def setup
    @product = products(:testone)
  end


  test "should get new" do
    get :new
    assert_response :success
  end

  test "should get create" do
    get :create
    assert_response :success
  end



end
