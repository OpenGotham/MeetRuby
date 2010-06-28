class Video < ActiveRecord::Base
  has_one :source, :as => :resourceful
  
end
