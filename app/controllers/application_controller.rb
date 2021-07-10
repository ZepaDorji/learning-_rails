class ApplicationController < ActionController::Base
    helper_method :current_user, :logged_in? 
    def current_user
        @current_user ||= User.find(session[:user_id]) if session[:user_id] 
        #if we have current user already it will not hit to db time and again.
    end

    def logged_in?
        !!current_user # coverting current user into boolean
    end
    
end
