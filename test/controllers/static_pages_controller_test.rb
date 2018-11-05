require 'test_helper'

class StaticPagesControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:michael)
  end

  test "should get home" do
    get static_pages_home_url
    assert_response :success
  end

  test "home : should show the right links when loggin" do
    post login_path, params: { session: { email:    @user.email, password: 'foobar' } }
    get root_path
    assert_select "a[href=?]", login_path, count: 0
    assert_select "a[href=?]", logout_path
    assert_select "a[href=?]", signup_path, count: 0
    assert_select "a[href=?]", users_path
  end

  test "home : should show the right links when not logged in" do
    get root_path
    assert_select "a[href=?]", login_path, count: 2
    assert_select "a[href=?]", logout_path, count: 0
    assert_select "a[href=?]", signup_path, count: 2
    assert_select "a[href=?]", users_path, count: 0
  end

  test "navbar: show the right links" do
    get root_path
    assert_select "a[href=?]", root_path, count: 1
    assert_select "a[href=?]", login_path, count: 2
    assert_select "a[href=?]", logout_path, count: 0
    assert_select "a[href=?]", signup_path, count: 2
    assert_select "a[href=?]", users_path, count: 0

  end
end
