class Category < ActiveRecord::Base
  has_ancestry
  has_and_belongs_to_many :sources
  acts_as_taggable_on :topic, :toolbox_topic
  named_scope :top_categories, :conditions => ["ancestry IS NULL"]
end
