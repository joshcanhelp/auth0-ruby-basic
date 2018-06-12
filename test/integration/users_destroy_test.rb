require 'test_helper'

class UsersDestroyTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:one)
    @user2 = users(:two)
    @admin = users(:admin)
  end

  test 'should not destroy user if not an admin' do
    # Not logged in.
    delete user_url @user
    assert_not flash.empty?
    assert_redirected_to login_url

    # Logged in as a non-admin
    log_in_as @user2
    delete user_url @user
    assert_not flash.empty?
    assert_redirected_to users_url
  end

  test 'should destroy user if admin' do
    log_in_as(@admin)
    assert_difference 'User.count', -1 do
      delete user_url @user
    end
    assert_redirected_to users_url
  end

end
