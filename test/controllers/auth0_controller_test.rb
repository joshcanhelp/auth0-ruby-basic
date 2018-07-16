require 'test_helper'

class Auth0ControllerTest < ActionDispatch::IntegrationTest
  test 'should get clients' do
    get auth0_clients_url
    assert_response :success
  end

  test 'should get connections' do
    get auth0_connections_url
    assert_response :success
  end

  test 'should get users' do
    get auth0_users_url
    assert_response :success
  end
end
