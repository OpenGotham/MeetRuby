class Source < ActiveRecord::Base
  has_many :labels
  has_many :authors
  has_many :profiles, :through => :authors
  has_and_belongs_to_many :categories
  image_accessor :primary_image            # Defines reader/writer for primary_image
 
  belongs_to :resourceful, :polymorphic => true
  
  has_many :posts
  acts_as_taggable_on :topic_categories, :importance

end
