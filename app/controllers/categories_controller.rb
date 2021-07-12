class CategoriesController < ApplicationController
    before_action :require_admin, except: [:index, :show]
    def new
        @category = Category.new()
    end
    def create
        @category = Category.new(category_params)
        if @category.save
            flash[:notice] = "Catergory was successfully created"
            redirect_to @category
        else
            render 'new'
        end
    end 

    def index
        @categories = Category.paginate(page: params[:page], per_page: 4)
    end 

    def show
        @category = Category.find(params[:id])
        @articles = @category.articles.paginate(page: params[:page], per_page: 3)
    end
    

    private
    def category_params
        params.require(:category).permit(:name)
    end

    def require_admin
      if  !(logged_in? && current_user.admin?)
        flash[:alert]= "only admin can performe this action"
        redirect_to categories_path
      end
    end
end