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

  test "index: should send back to login page if not logged in" do
    get users_path
    follow_redirect!
    assert_template 'sessions/new'
  end

  test "index: should show index if logged in" do
    post users_path, params: { user: { first_name: @user.first_name, last_name: @user.last_name, mail: @user.email, password: 'foobar', password_confirmation: "foobar" } }
    post login_path, params: { session: { email:@user.email, password: 'foobar' } }
    get users_path
    assert_template 'users/index'
  end

  test "show: show link to profile only to logged users" do
    post users_path, params: { user: { first_name: @user.first_name, last_name: @user.last_name, mail: @user.email, password: 'foobar', password_confirmation: "foobar" } }
    post login_path, params: { session: { email:@user.email, password: 'foobar' } }
    get user_path(@user.id)
  end

  test "show: show users info when logged in" do
    post login_path, params: { session: { email:@user.email, password: 'foobar' } }
    get user_path(@user.id)
  end

  test "show: show page only to logged users" do
    get user_path(@user.id)
    assert_template 'sessions/new'
  end

  test "show: should send back to login page if not logged in" do
    get user_path(@user.id)
    follow_redirect!
    assert_template 'sessions/new'
  end

  test "edit: edit user's profile" do
    post login_path, params: { session: { email:@user.email, password: 'foobar' } }
    get user_path(@user.id)
    get edit_user_path
    put user_path, params: {user: {first_name: @user.first_name, last_name: @user.last_name, email: @user.email}}
    get user_path(@user.id)
  end

end
