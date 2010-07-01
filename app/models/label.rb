class Label < ActiveRecord::Base
  belongs_to :source
  belongs_to :topic
end
