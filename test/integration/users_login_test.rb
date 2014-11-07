require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest

    def setup
    @user = users(:michael)
  end
  

  test "login with valid information" do
    get signin_path
    post signin_path, session: { email: @user.email, password: 'password' }
    assert_redirected_to @user
    follow_redirect!
    assert_template 'users/show'
    assert_select "a[href=?]", signin_path, count: 0
    assert_select "a[href=?]", signout_path
    assert_select "a[href=?]", user_path(@user)
  end

    test "login with valid information followed by logout" do
    get signin_path
    post signin_path, session: { email: @user.email, password: 'password' }
    assert is_logged_in?
    assert_redirected_to @user
    follow_redirect!
    assert_template 'users/show'
    assert_select "a[href=?]", signin_path, count: 0
    assert_select "a[href=?]", signout_path
    assert_select "a[href=?]", user_path(@user)
    delete signout_path
    assert_not is_logged_in?
    assert_redirected_to root_url
    follow_redirect!
    assert_select "a[href=?]", signin_path
    assert_select "a[href=?]", signout_path,      count: 0
    assert_select "a[href=?]", user_path(@user), count: 0
  end
end