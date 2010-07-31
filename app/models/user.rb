class User < ActiveRecord::Base

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :oauth2_authenticatable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  # devise :oauth2_authenticatable, :registerable,
  #        :recoverable, :rememberable, :trackable, :validatable
  # 
  # # Setup accessible (or protected) attributes for your model
  # attr_accessible :email, :password, :password_confirmation, :remember_me
  # Include default devise modules. Others available are:
  # :token_authenticatable, :lockable, :timeoutable and :activatable
  #devise :oauth2_authenticatable #, :database_authenticatable, :registerable, :confirmable, 
  #          :recoverable, :rememberable, :trackable, :validatable
  # 
  #   # Setup accessible (or protected) attributes for your model
  #   attr_accessible :email, :password, :password_confirmation
  #   def self.create_from_oauth_user(oauth_user)
  #     User.create(:oauth_user => oauth_user)
  #   end
  
  has_many :posts
end
