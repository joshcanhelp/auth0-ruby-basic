require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:one)
    @user2 = users(:two)
  end

  test 'unsuccessful user edit' do
    log_in_as(@user)
    get edit_user_path(@user)
    assert_template 'users/edit'
    patch user_path(@user), params:
      { user:
        {
          name:  '',
          email: "foo@invalid",
          password: "foo",
          password_confirmation: "bar"
        }
    }
    assert_template 'users/edit'
    assert_select 'div.alert-danger ul li', 4
  end

  test 'successful user edit with friendly forwarding' do
    get edit_user_path(@user)
    log_in_as(@user)
    assert_redirected_to edit_user_url(@user)

    new_name = 'New User'
    new_email = 'example@auth0.com'
    patch user_path(@user), params:
      { user:
        {
          name:  new_name,
          email: new_email,
          password: '',
          password_confirmation: ''
        }
    }
    assert_not flash.empty?
    assert_redirected_to @user
    @user.reload
    assert_equal new_name, @user.name
    assert_equal new_email, @user.email
  end

  test 'should redirect edit when logged in as wrong user' do
    log_in_as(@user2)
    get edit_user_path(@user)
    assert_not flash.empty?
    assert_redirected_to users_path
  end

  test 'should redirect update when logged in as wrong user' do
    log_in_as(@user2)
    patch user_path(@user), params: {
      user: {
        name: @user2.name,
        email: @user2.email
      }
    }
    assert_not flash.empty?
    assert_redirected_to users_path
  end
end
