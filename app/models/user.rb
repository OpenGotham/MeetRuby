class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :oauthable, :meetup_authenticatable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  has_one :profile
  has_many :meetup_users
  has_many :github_users
  has_many :posts
  # def oauth_meetup_token
  #     @oauth_meetup_token ||= self.class.oauth_access_token(:meetup, meetup_token)
  # end
  
  def oauth_github_token
      @oauth_github_token ||= self.class.oauth_access_token(:github, github_token)
  end
  
  # def self.new_with_session(params, session)
  #     super.tap { |u| u.github_token = session[:user_github_oauth_token] }
  #   end
  # def self.find_for_meetup_oauth(access_token, signed_in_resource=nil)
  #       # Get the user email info from meetup for sign up
  #       data = ActiveSupport::JSON.decode(access_token.get('/api/v2/json/user/show'))["user"]
  #   
  #      
  #       # Link the account if an e-mail already exists in the database
  #       # or a signed_in_resource, which is already in session was given.
  #       if user = signed_in_resource || User.find_by_email(data["email"])
  #         
  #         
  #         user.update_attribute(:meetup_token, access_token.token)
  #         user
  #       else
  #         User.create!(:name => user["name"], :email => user["email"],
  #           :password => Devise.friendly_token){ |u| u.meetup_token = access_token.token }
  #       end
  #   
  #   
  #     end
   
  def self.find_for_github_oauth(access_token, signed_in_resource=nil)
     # Get the user email info from Github for sign up
     
     data = ActiveSupport::JSON.decode(access_token.get('/api/v2/json/user/show'))["user"]
     plan = data["plan"]
     logger.info("user data "+data.to_yaml)

    # Link the account if an e-mail already exists in the database
    # or a signed_in_resource, which is already in session was given.
    if user = signed_in_resource || User.find_by_email(data["email"])
     user.update_attribute(:github_token, access_token.token)
      if user.github_users.blank?
        user.github_users.create(:gravatar_id => data["gravatar_id"], :plan_name => plan["name"], :plan_collaborators => plan["collaborators"], :plan_space => plan["space"], :plan_private_repos => plan["private_repos"], :on_github_since => data["created_at"], :location => data["location"], :blog => data["blog"], :public_gist_count => data["public_gist_count"], :public_repo_count => data["public_repo_count"], :collaborators => data["collaborators"], :disk_usage => data["disk_usage"], :following_count => data["following_count"], :git_hub_id => data["git_hub_id"], :type => data["type"], :private_gist_count => data["private_gist_count"], :owned_private_repo_count => data["owned_private_repo_count"], :followers_count => data["followers_count"], :total_private_repo_count => data["total_private_repo_count"], :login => data["login"], :email => data["email"])
      end
      if user.profile.blank?
        user.profile = Profile.create(:full_name => data["name"], :github_url => data["login"])
      end
      logger.info(access_token.to_yaml)
      logger.info(data.to_yaml)
      user
     else
       logger.info(access_token.to_yaml)
       logger.info(data.to_yaml)
       profile = Profile.new(:full_name => data["name"], :github_url => data["login"])
       User.create!(:email => data["email"],
         :password => Devise.friendly_token, profile => profile){ |u| u.github_token = access_token.token }
     end
     
     
     
   end
  
end
