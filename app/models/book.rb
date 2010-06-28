class Book < ActiveRecord::Base
  has_one :source, :as => :resourceful
  has_many :prices
end
