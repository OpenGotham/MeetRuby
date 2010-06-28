class Profile < ActiveRecord::Base
  has_one :source, :as => :resourceful
  has_many :labels, :as => :skills
  has_many :sources, :as => :works
  has_one :user
end
