require 'test_helper'

class CommentsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:one)
    @user2 = users(:two)
    @admin = users(:admin)
    @article = articles(:one)
  end

  test 'can create a comment if logged in' do
  end

  test 'cannot create a comment if not logged in' do
  end

  test 'can destroy a comment if admin or author' do
  end

  test 'logged out user cannot destroy a comment' do
  end

  test 'cannot destroy a comment you did not create' do
  end
end
