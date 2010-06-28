class Post < ActiveRecord::Base
  belongs_to :user
  has_one :source, :as => :resourceful
  
  
end
