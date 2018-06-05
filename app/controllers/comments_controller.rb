class CommentsController < ApplicationController

  #
  # Create Comment endpoint handler
  #
  def create
    @article = Article.find(params[:article_id])
    @comment = @article.comments.create(comment_params)
    redirect_to article_path(@article)
  end

  #
  # Delete Comment endpoint handler
  #
  def destroy
    @article = Article.find(params[:article_id])
    @comment = @article.comments.find(params[:id])
    @comment.destroy
    redirect_to article_path(@article)
  end

  #
  # PRIVATE
  #
  private

    #
    # Require and permit Comment parameters
    #
    def comment_params
      params.require(:comment).permit(:commenter, :body)
    end
end
