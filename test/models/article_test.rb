require 'test_helper'

class ArticleTest < ActiveSupport::TestCase

  def setup
    @author = users(:one)
    @article = Article.new(
      title: '12345',
      text: '12345678901234567890123456789012345678901234567890',
      user_id: @author.id
    )
  end

  test "should be valid" do
    assert @article.valid?
  end

  test "title should be present" do
    @article.title = "     "
    assert_not @article.valid?
  end

  test "title should not be too short" do
    @article.title = "1234"
    assert_not @article.valid?
  end

  test "text should be present" do
    @article.text = "     "
    assert_not @article.valid?
  end

  test "text should not be too short" do
    @article.text = "1234"
    assert_not @article.valid?
  end
end
