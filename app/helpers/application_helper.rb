module ApplicationHelper
  #for user image 
    def gravatar_for(user, options = { size: 80})
        email_address = user.email.downcase
        hash = Digest::MD5.hexdigest(email_address)
        size = options[:size]
        gravatar_url = "https://www.gravatar.com/avatar/#{hash}?s=#{size}"
        image_tag(gravatar_url, alt: user.username)
      end

      def current_user
        @current_user ||= User.find(session[:user_id]) if session[:user_id] 
        #if we have current user already it will not hit to db time and again.
         
      end

      def logged_in?
        !!current_user # coverting current user into boolean
      end
end
