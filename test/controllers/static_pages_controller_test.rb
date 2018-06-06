require 'test_helper'

class StaticPagesControllerTest < ActionDispatch::IntegrationTest

  def setup
    @base_title = "Basic Auth0 Ruby App"
    @title_sep = " | "
  end

  test "should get root" do
    get root_path
    assert_response :success
    assert_select "title", "Home#{@title_sep}#{@base_title}"
  end

  test "should get home" do
    get static_pages_home_url
    assert_response :success
    assert_select "title", "Home#{@title_sep}#{@base_title}"
  end

  test "should get help" do
    get static_pages_help_url
    assert_response :success
    assert_select "title", "Help#{@title_sep}#{@base_title}"
  end

  test "should get about" do
    get static_pages_about_url
    assert_response :success
    assert_select "title", "About#{@title_sep}#{@base_title}"
  end

end
