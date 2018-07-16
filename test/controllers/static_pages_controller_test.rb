require 'test_helper'

class StaticPagesControllerTest < ActionDispatch::IntegrationTest
  def setup
    @base_title = 'Basic Auth0 Ruby App'
    @title_sep = ' | '
  end

  test 'should get root' do
    get root_path
    assert_response :success
    assert_select 'title', @base_title.to_s
  end

  test 'should get home' do
    get static_pages_home_url
    assert_response :success
    assert_select 'title', @base_title.to_s
  end
end
