class Event < ActiveRecord::Base
  has_one :source, :as => :resourceful
  
  has_one :venue
  has_many :prices
  
end
