class Inquiry < ActiveRecord::Base
  has_and_belongs_to_many :inquiry_choices
end
