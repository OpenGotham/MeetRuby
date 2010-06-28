class Conference < ActiveRecord::Base
  has_one :source, :as => :resourceful
  has_many :posts, :as => :tracks
  
  has_one :venue

end
