class ArticlesController < ApplicationController
  before_action :set_article, only: [:edit, :update, :show, :destroy]

  def index
    @articles = Article.paginate(page: params[:page], per_page: 5)
  end

  def new
    @article = Article.new
  end

  def edit
  end

  def create
    @article = Article.new(article_params)
    @article.user = User.first #placeholder

    if @article.save
      flash[:success] = 'Article was successfully created'
      redirect_to article_path(@article)
    else
      flash.now[:danger] = @article.errors.full_messages.join("<li>").html_safe
      render :new
    end
  end

  def update
    if @article.update(article_params)
      flash[:success] = 'Article was successfully updated'
      redirect_to article_path(@article)
    else
      flash.now[:danger] = @article.errors.full_messages.join("<li>").html_safe
      render :edit
    end
  end

  def show
  end

  def destroy
    if @article.destroy
      flash[:success] = 'Article successfully deleted'
    else
      flash[:danger] = 'Article could not be deleted'
    end

    redirect_to articles_path
  end

  private
    def article_params
      params.require(:article).permit(:title, :description)
    end

    def set_article
      @article = Article.find(params[:id])
    end
end
