class Source < ActiveRecord::Base
  has_many :labels
  has_many :authors
  has_many :profiles, :through => :authors
  #image_accessor :primary_image            # Defines reader/writer for primary_image
 
  belongs_to :resourceful, :polymorphic => true
  
  has_many :posts
  acts_as_taggable_on :categories, :importance

end
