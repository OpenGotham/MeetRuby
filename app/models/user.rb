class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
           :recoverable, :rememberable, :trackable, :validatable, :omniauthable
  
  attr_accessible :email, :password, :password_confirmation#, :remember_me
  

  has_one :profile
  has_many :user_tokens
  has_many :meetup_users
  has_many :github_users
  has_many :posts


  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session[:omniauth]
        logger.error("in new_with_session of user #{data.to_yaml}")
        user.user_tokens.build(:provider => data['provider'], :uid => data['uid']|| data["extra"]["access_token"].ivars["params"]["member_id"])
      end
    end
  end

  def apply_omniauth(omniauth)
    #add some info about the user
    #self.name = omniauth['user_info']['name'] if name.blank?
    #self.nickname = omniauth['user_info']['nickname'] if nickname.blank?
    
    logger.error("in new_with_session of user #{omniauth.to_yaml}")
    unless omniauth['credentials'].blank?
      user_tokens.build(:provider => omniauth['provider'], :uid => omniauth['uid']||omniauth['member_id'])
      #user_tokens.build(:provider => omniauth['provider'], 
      #                  :uid => omniauth['uid'],
      #                  :token => omniauth['credentials']['token'], 
      #                  :secret => omniauth['credentials']['secret'])
    else
      user_tokens.build(:provider => omniauth['provider'], :uid => omniauth['uid']||omniauth['member_id'])
    end
    #self.confirm!# unless user.email.blank?
  end

  def password_required?
    (user_tokens.empty? || !password.blank?) && super  
  end
  # 
  # def self.find_for_github_oauth(access_token, signed_in_resource=nil)
  #   logger.info("in find_for_github_oauth of user")
  #    data = access_token['extra']['user_hash']
  #    if user = User.find_by_email(data["email"])
  #      logger.info("**user found: #{user}")
  #      user
  #    else # Create an user with a stub password. 
  #     logger.info("**user not found: #{data}")
  #      User.create!(:email => data["email"], :password => Devise.friendly_token[0,20]) 
  #    end
  #  end
  #  def self.find_for_meetup_oauth(access_token, signed_in_resource=nil)
  #    logger.info("in find_for_meetup_oauth of user ")
  #     data = access_token['extra']['user_hash']
  #     if user = User.find_by_email(data["email"])
  #       logger.info("**user found: #{user}")
  #       user
  #     else # Create an user with a stub password. 
  #      logger.info("**user not found: #{data}")
  #       User.create!(:email => data["email"], :password => Devise.friendly_token[0,20]) 
  #     end
  #   end
  
end
