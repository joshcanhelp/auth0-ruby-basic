class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy, :correct_user]
  before_action :is_author, only: [:new, :create, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update, :destroy]

  #
  # New Article view handler
  #
  def new
    @article = Article.new
  end

  #
  # Edit Article view handler
  #
  def edit

  end

  #
  # Single Article view handler
  #
  def show
    store_forwarding_loc
    @author = User.find_by(id: @article.user_id)
  end

  #
  # All Articles view handler
  #
  def index
    @articles = Article.all
  end

  #
  # Create Article endpoint handler
  #
  def create
    @article = Article.new(
      title: article_params[:title],
      text: article_params[:text],
      user_id: current_user.id
    )
    if @article.save
      redirect_to @article
    else
      render 'new'
    end
  end

  #
  # Update Article endpoint handler
  #
  def update
    if @article.update(article_params)
      redirect_to @article
    else
      render 'edit'
    end
  end

  # Delete Article endpoint handler
  def destroy

    @article.destroy
    redirect_to articles_path
  end

  #
  # START - Private methods
  #
  private

    # Require and permit Article parameters
    def article_params
      params.require(:article).permit(:title, :text)
    end

    #
    # START - Before filters
    #

    # Set the article we're working on.
    def set_article
      @article = Article.find(params[:id])
    end

    # Make sure we have an author.
    def is_author
      unless logged_in? && current_user.is_author
        flash[:danger] = 'Not authorized.'
        redirect_to articles_url
      end
    end

    # Make sure we have the correct user.
    def correct_user
      unless current_user.id == @article.user_id
        flash[:danger] = 'Not authorized.'
        redirect_to users_path
      end
    end

end
