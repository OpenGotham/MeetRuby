class Topic < ActiveRecord::Base
  has_many :subtopics, :class_name => "Topic", :foreign_key => "supertopic_id"
  belongs_to :supertopic, :class_name => "Topic"
  has_many :labels
end
