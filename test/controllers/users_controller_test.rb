require 'test_helper'
require 'json'


class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
  end

  test "should get index" do
    get users_url
    assert_response :success
  end

  test "should get new user page" do
    get new_user_url
    assert_response :success
  end

  test "should get signup page" do
    get signup_path
    assert_response :success
  end

  test "should show user" do
    get user_url(@user)
    assert_response :success
  end

  test "should get edit" do
    get edit_user_url(@user)
    assert_response :success
  end

  test "should create user" do
    assert_difference('User.count') do
      post users_url, params: {
        user: {
          name: @user.name,
          email: 'unique1' + @user.email,
          password: @user.password_digest,
          password_confirmation: @user.password_digest,
          auth0_id: 'unique1' + @user.auth0_id
        }
      }
    end

    assert_redirected_to user_url(User.last)
  end

  test "should reject different passwords" do
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

  test "should reject duplicate emails" do
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

  test "should reject short passwords" do
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

  test "should reject duplicate auth0 IDs" do
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

  test "should update user" do
    patch user_url(@user), params: {
      user: {
        name: @user.name,
        email: @user.email,
        password: @user.password_digest,
        password_confirmation: @user.password_digest,
        auth0_id: @user.auth0_id
      }
    }
    assert_redirected_to user_url(@user)
  end

  test "should destroy user" do
    assert_difference('User.count', -1) do
      delete user_url(@user)
    end

    assert_redirected_to users_url
  end
end
