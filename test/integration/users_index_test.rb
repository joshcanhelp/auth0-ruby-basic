# require 'test_helper'
#
# class UsersIndexTest < ActionDispatch::IntegrationTest
#
#   def setup
#     @user = users(:one)
#   end
#
#   test 'should show users index including pagination when logged in' do
#     log_in_as(@user)
#     get users_path
#     assert_response :success
#     assert_template 'users/index'
#     assert_select 'div.pagination'
#     User.paginate(page: 1, per_page: 20).order('created_at DESC').each do |user|
#       assert_select 'a[href=?]', user_path(user), text: user.name
#     end
#   end
# end
