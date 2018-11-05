require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:michael)
  end

  test "signup: should show errors messages if email already exist" do
    post users_path, params: { user: { first_name: @user.first_name, last_name: @user.last_name, mail: @user.email, password: 'foobar', password_confirmation: "foobar" } }
    get root_path
    get signup_path
    post users_path, params: { user: { first_name: @user.first_name, last_name: @user.last_name, mail: @user.email, password: 'foobar', password_confirmation: "foobar" } }
    assert_select "li", 6
  end

  test "signup : should show error messages if blank fields" do
    post users_path, params: { user: { first_name: " ", last_name: " ", email: " ", password: 'foobar', password_confirmation: "foobar" } }
    assert_select "li", 8
  end

  test "should reject if not logged in" do
    get users_path
    follow_redirect!
    assert_template 'sessions/new'
  end
end
