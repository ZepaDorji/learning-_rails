class ArticlesController < ApplicationController
    before_action :set_article, only: [:show, :edit, :update, :destroy]
    before_action :required_user, except: [:index, :show]
    before_action :required_same_user, only: [:edit, :update, :destroy]
    def show
        #@article = Article.find(params[:id])
    end

    def index 
        @articles = Article.paginate(page: params[:page], per_page: 5)

    end

    def new
        @article = Article.new
    end

    def edit
        #@article = Article.find(params[:id])
    end

    def create
        @article = Article.new(article_params)#params.require(:article).permit(:title, :description ))
        @article.user = current_user         # for adding new artile after association, for error user must exit.
       if @article.save
            flash[:notice] = "The articles was succefully created"
            redirect_to @article  #after saving this will show the information you just created
       else
        render 'new'
       end
    end

    def update
        #@article = Article.find(params[:id])
        if @article.update(article_params)#params.require(:article).permit(:title, :description ))
            flash[:notice] = "The articles was succefully updated"
            redirect_to @article  #after saving this will show the information you just created
       else
        render 'edit'
        end 
    end
    def destroy 
        #@article = Article.find(params[:id])
        @article.destroy
        redirect_to articles_path
    end 

    private

    def set_article
        @article = Article.find(params[:id])
    end
    def article_params
        params.require(:article).permit(:title, :description )
    end
    def required_same_user
        if current_user != @article.user
            flash[:alert] = "You can only edit or delete your own article"
            redirect_to @article
        end
    end
end