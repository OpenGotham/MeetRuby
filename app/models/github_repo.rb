class GithubRepo < ActiveRecord::Base
  belongs_to :github_user
end
