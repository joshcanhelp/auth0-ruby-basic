class ArticlesController < ApplicationController

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
    @article = Article.find(params[:id])
  end

  #
  # Single Article view handler
  #
  def show
    @article = Article.find(params[:id])
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
    # render plain: params[:article].inspect
    @article = Article.new(article_params)
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
    @article = Article.find(params[:id])
    if @article.update(article_params)
      redirect_to @article
    else
      render 'edit'
    end
  end

  #
  # Delete Article endpoint handler
  #
  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    redirect_to articles_path
  end

  #
  # PRIVATE
  #
  private

    #
    # Require and permit Article parameters
    #
    def article_params
      params.require(:article).permit(:title, :text, :user_id)
    end
end
