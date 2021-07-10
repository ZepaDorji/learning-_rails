class UsersController < ApplicationController

    before_action :set_user, only:[:show, :edit, :update]

    def index
        @users = User.paginate(page: params[:page], per_page: 3)
    end
    
    def new
        @user = User.new
    end

    def show
        #@user = User.find(params[:id])
        @articles = @user.articles.paginate(page: params[:page], per_page: 5)
    end

    def edit
        #@user = User.find(params[:id])
    end

    def update
        #@user = User.find(params[:id])
        if @user.update(user_params)
            flash[:notice] = "Your information is succssfully updated"
            redirect_to @user
        else
            render 'edit'
        end
    end

    def create 
        @user = User.new(user_params)
        if @user.save
            session[:user_id] = @user.id
            flash[:notice] = "WELLCOME TO BLOG #{@user.username}, you have succssfully sing up "
            redirect_to articles_path
        else
            render 'new'
        end 
    end

    private
    def user_params
        params.require(:user).permit(:username, :email, :password)
    end
    def set_user
        @user = User.find(params[:id])
    end
end