class Admin::ArticlesController < Admin::ApplicationController
  before_action :set_admin_article, only: [:show, :edit, :update, :destroy]

  def index
   # @articles = Article.where(:section_id => params[:cat])
    @articles = Article.order(position: :asc)
  end

  def reorder
    params[:article].each_with_index do |id, index|
      Article.where(id: id).update_all(position: index + 1) 
    end
    head :ok
  end    

  def new
    @article = Article.new(:section_id => params[:cat])
  end

  def edit
    @article = Article.find(params[:id])
  end

  def create
    @article = Article.new(article_params)
    respond_to do |format|
      if @article.save
        format.html { redirect_to admin_articles_url(:cat => @article.section_id), notice: 'Article was successfully created.' }
        format.json { render :show, status: :created, location: @article }
      else
        format.html { render :new }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    if @article.update(article_params)
      redirect_to admin_articles_url(:cat => @article.section_id), notice: 'Artikkelen: ' + article_params[:title] + ' ble oppdatert!'
    else
      flash[:alert] = 'Det var et problem med oppdateringen'
      render :edit
    end   
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    redirect_to admin_articles_url(:cat => @article.section_id), notice: 'Artikkelen ble slettet!'
  end

  private

    def set_admin_article
      @article = Article.find(params[:id])
    end

    def article_params
      params.require(:article).permit(:title, :summary, :content, :image, :ispublished, :section_id, :remove_image, :template, :position)
    end

end
