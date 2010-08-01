class ApplicationController < ActionController::Base
  protect_from_forgery
  layout 'application'
  before_filter :authenticate_user!
  
  
  #@oauth_consumer = OAuth::Consumer.new("ABDAE5ED0962D3332A0B546174997828", "856263601BB15FA05D1062AA082FF6CD", { :site=>"http://www.meetup.com", :request_token_path=>"/oauth/request/", :authorize_path => "/authorize", :access_token_url =>"/oauth/access/" })
  private
    # def current_user_session
    #       return @current_user_session if defined?(@current_user_session)
    #       @current_user_session = UserSession.find
    #     end
    # 
    #     def current_user
    #       return @current_user if defined?(@current_user)
    #       @current_user = current_user_session && current_user_session.user
    #     end
    #      def require_user
    #         unless current_user
    #           store_location
    #           flash[:notice] = "You must be logged in to access this page"
    #           redirect_to new_user_session_url
    #           return false
    #         end
    #       end
    #       def require_no_user
    #         if current_user
    #           return false
    #         end
    #       end
      
end
