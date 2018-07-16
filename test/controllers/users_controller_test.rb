require 'test_helper'
require 'json'

class UsersControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:one)
    @user2 = users(:two)
    @admin = users(:admin)
  end

  test 'should redirect index when not logged in' do
    get users_path
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  # test 'should get signup page' do
  #   get signup_path
  #   assert_response :success
  # end

  test 'should show user' do
    get user_url(@user)
    assert_response :success
  end

  test 'should reject different passwords on create' do
    assert_no_difference('User.count') do
      post users_url, params: {
        user: {
          name: @user.name,
          email: 'unique2' + @user.email,
          password: 'hippity-hop',
          password_confirmation: 'shippity-shlop',
          auth0_id: 'unique2' + @user.auth0_id
        }
      }
      assert_template 'users/new'
    end
  end

  test 'should reject duplicate emails on create' do
    assert_no_difference('User.count') do
      post users_url, params: {
        user: {
          name: @user.name,
          email: @user.email,
          password: @user.password_digest,
          password_confirmation: @user.password_digest,
          auth0_id: 'unique3' + @user.auth0_id
        }
      }
      assert_template 'users/new'
    end
  end

  test 'should reject short passwords on create' do
    assert_no_difference('User.count') do
      post users_url, params: {
        user: {
          name: @user.name,
          email: 'unique3' + @user.email,
          password: '1234567',
          password_confirmation: '1234567',
          auth0_id: 'unique3' + @user.auth0_id
        }
      }
      assert_template 'users/new'
    end
  end

  test 'should reject duplicate auth0 IDs on create' do
    assert_no_difference('User.count') do
      post users_url, params: {
        user: {
          name: @user.name,
          email: 'unique3' + @user.email,
          password: @user.password_digest,
          password_confirmation: @user.password_digest,
          auth0_id: @user.auth0_id
        }
      }
      assert_template 'users/new'
    end
  end

  test 'should redirect edit when not logged in' do
    get edit_user_path(@user)
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test 'should redirect update when not logged in' do
    patch user_path(@user), params: {
      user: {
        name: "Add #{@user.name}",
        email: "add+#{@user.email}"
      }
    }
    assert_not flash.empty?
    assert_redirected_to login_url
  end
end
