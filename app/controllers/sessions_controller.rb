class SessionsController < ApplicationController

    def new
    end

    def create
        user = User.find_by(email: params[:session][:email].downcase) # this seach for the user exit in db
        if user && user.authenticate(params[:session][:password]) # if user found and password matched
            session[:user_id] = user.id
            flash[:notice] = "Log In successfull"
            redirect_to user
        else
            flash.now[:alert] = "Login Failed"
            render 'new'
        end
    end

    def destroy
        session[:user_id] = nil
        flash[:notice] = "You log out successfully"
        redirect_to root_path
    end
end