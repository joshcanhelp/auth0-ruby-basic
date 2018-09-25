# ArticlesController - :articles resource controller.
#
require 'auth0'

class ArticlesController < ApplicationController
  before_action :set_article, only: %i[show edit update destroy correct_user]
  before_action :author?, only: %i[new create edit update destroy]
  before_action :correct_user, only: %i[edit update destroy]

  # GET /articles
  def index
    @articles = Article.all
  end

  # GET /articles/1
  def show
    store_forwarding_loc
    @author = User.find_by(id: @article.user_id)
  end

  # GET /articles/new
  def new
    @article = Article.new
  end

  # GET /articles/1/edit
  def edit
    render 'edit'
  end

  # POST /articles
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

  # PATCH/PUT /articles/1
  def update
    if @article.update(article_params)
      redirect_to @article
    else
      render 'edit'
    end
  end

  # DELETE /articles/1
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
  def author?
    return if logged_in? && current_user_is_author?
    flash[:danger] = 'Not authorized.'
    redirect_to articles_url
  end

  # Make sure we have the correct user.
  def correct_user
    return if current_user_is_admin? || current_user.id == @article.user_id
    flash[:danger] = 'Not authorized.'
    redirect_to users_path
  end
end
