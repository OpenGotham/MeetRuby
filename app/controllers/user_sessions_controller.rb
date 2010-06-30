class UserSessionsController < ApplicationController
  before_filter :require_no_user, :only => [:new, :create]
  before_filter :require_user, :only => :destroy
  def new
    redirect_back_or_default if current_user
    @user_session = UserSession.new
  end
  def create
    current_user_session.destroy if current_user_session
    @user_session = UserSession.new(params[:user_session])
    if @user_session.save
      flash[:notice] = "Login successful!"
    else
      render :action => :new
    end
  end
  def destroy
     current_user_session.destroy
     flash[:notice] = "Logout successful!"
     redirect_back_or_default new_user_session_url
   end
   # def auth
   #     @oauth_consumer ||= OAuth::Consumer.new("ABDAE5ED0962D3332A0B546174997828", "856263601BB15FA05D1062AA082FF6CD", :site => "http://www.meetup.com/", :request_token_url => "http://www.meetup.com/oauth/request/", :authorize_path => 'authorize/', :access_token_path => 'oauth/access/', :oauth_callback => "oob", :http_method => :post)
   #     @request_token = @oauth_consumer.get_request_token
   #     redirect_to @request_token.authorize_url
   #  end
end
