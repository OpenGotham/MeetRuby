class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :omniauthable, :database_authenticatable
  #, :omniauth_providers => [:github]
  # devise_for :database_authenticatable, :omniauthable, :omniauth_providers => [:github]
  attr_accessible :email, :password, :password_confirmation#, :remember_me
  

  has_one :profile
  has_many :meetup_users
  has_many :github_users
  has_many :posts

  def self.find_for_github_oauth(access_token, signed_in_resource=nil)
    logger.info("in find_for_github_oauth of user")
     data = access_token['extra']['user_hash']
     if user = User.find_by_email(data["email"])
       logger.info("**user found: #{user}")
       user
     else # Create an user with a stub password. 
      logger.info("**user not found: #{data}")
       User.create!(:email => data["email"], :password => Devise.friendly_token[0,20]) 
     end
   end
   def self.find_for_meetup_oauth(access_token, signed_in_resource=nil)
     logger.info("in find_for_meetup_oauth of user")
      data = access_token['extra']['user_hash']
      if user = User.find_by_email(data["email"])
        logger.info("**user found: #{user}")
        user
      else # Create an user with a stub password. 
       logger.info("**user not found: #{data}")
        User.create!(:email => data["email"], :password => Devise.friendly_token[0,20]) 
      end
    end
  
end
