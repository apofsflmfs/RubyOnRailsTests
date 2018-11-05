require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:michael)
  end

  test "should get new" do
    get login_url
    assert_response :success
  end

  test "login : should login if all fields ok" do
    post users_path, params: { user: { first_name: @user.first_name, last_name: @user.last_name, mail: @user.email, password: 'foobar', password_confirmation: "foobar" } }

    post login_path, params: { session: { email: @user.email, password: 'foobar' } }
  end

  test "login : should show error messages if blank fields or wrong parameter" do
    post users_path, params: { user: { first_name: " ", last_name: " ", email: " ", password: " ", password_confirmation: " " } }
    assert_select "li", 10
  end

end
