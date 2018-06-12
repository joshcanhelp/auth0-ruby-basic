class CommentsController < ApplicationController
  before_action :set_article
  before_action :logged_in
  before_action :correct_user, only: [:destroy]

  # Create Comment endpoint handler
  def create
    @comment = @article.comments.create(
      body: comment_params[:body],
      user_id: current_user.id
    )
    redirect_to article_path @article
  end

  # Delete Comment endpoint handler
  def destroy
    @comment = @article.comments.find(params[:id])
    @comment.destroy
    redirect_to article_path @article
  end

  #
  # START - Private methods
  #
  private

    # Require Comment params, whitelist incoming
    def comment_params
      params.require(:comment).permit(:body)
    end

    #
    # START - Before filters
    #

    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = Article.find(params[:article_id])
    end

    # Make sure the user is logged in.
    def logged_in
      unless logged_in?
        store_forwarding_loc
        flash[:danger] = 'You must be logged in to comment.'
        redirect_to login_url
      end
    end

    # Make sure we have the correct user.
    def correct_user
      unless current_user.is_admin || current_user.id == @comment.user_id
        flash[:danger] = 'Not authorized.'
        redirect_to users_path
      end
    end

end
