require 'test_helper'

class ArticlesControllerTest < ActionDispatch::IntegrationTest

  def setup
    @article = articles(:one)
  end

  test 'should get article index page' do
    get articles_url
    assert_response :success
  end
end
