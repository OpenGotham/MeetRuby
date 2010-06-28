class Author < ActiveRecord::Base
  belongs_to :source
  belongs_to :profile
end
