class Profile < ActiveRecord::Base
  has_one :source, :as => :resourceful
  has_many :labels, :as => :skills
  has_many :sources, :as => :works
  belongs_to :user
end
