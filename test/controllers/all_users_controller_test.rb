require 'test_helper'

class AllUsersControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get all_users_index_url
    assert_response :success
  end

end
