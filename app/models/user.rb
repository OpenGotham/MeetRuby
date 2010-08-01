class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :oauthable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me

  has_many :posts
  def oauth_meetup_token
      @oauth_meetup_token ||= self.class.oauth_access_token(:meetup, meetup_token)
  end
  
  def oauth_github_token
      @oauth_github_token ||= self.class.oauth_access_token(:github, github_token)
    end
  # 
  # def self.new_with_session(params, session)
  #     super.tap { |u| u.github_token = session[:user_github_oauth_token] }
  #   end
  def self.find_for_meetup_oauth(access_token, signed_in_resource=nil)
       # Get the user email info from Github for sign up
       data = ActiveSupport::JSON.decode(access_token.get('/api/v2/json/user/show'))["user"]
   
   
       # Link the account if an e-mail already exists in the database
       # or a signed_in_resource, which is already in session was given.
       if user = signed_in_resource || User.find_by_email(data["email"])
         user.update_attribute(:meetup_token, access_token.token)
         user
       else
         User.create!(:name => user["name"], :email => user["email"],
           :password => Devise.friendly_token){ |u| u.meetup_token = access_token.token }
       end
   
   
     end
   
  def self.find_for_github_oauth(access_token, signed_in_resource=nil)
     # Get the user email info from Github for sign up
     data = ActiveSupport::JSON.decode(access_token.get('/api/v2/json/user/show'))["user"]


     # Link the account if an e-mail already exists in the database
     # or a signed_in_resource, which is already in session was given.
     if user = signed_in_resource || User.find_by_email(data["email"])
       user.update_attribute(:github_token, access_token.token)
       user 
     else
       logger.info(access_token.to_yaml)
       logger.info(data.to_yaml)
       #if params[:code] && user["email"].blank?
         
       #else
         
         User.create!(:name => data["name"], :email => data["email"],
         :password => Devise.friendly_token){ |u| u.github_token = access_token.token }
       #end
     end
     
     
   end
  
end
