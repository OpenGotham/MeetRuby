class CreateGithubUsers < ActiveRecord::Migration
  def self.up
    create_table :github_users do |t|
      t.integer :user_id
      t.string :gravatar_id
      t.string :plan_name
      t.integer :plan_collaborators
      t.integer :plan_space
      t.integer :plan_private_repos
      t.datetime :on_github_since
      t.string :location
      t.string :blog
      t.integer :public_gist_count
      t.integer :public_repo_count
      t.integer :collaborators
      t.integer :disk_usage
      t.integer :following_count
      t.integer :git_hub_id
      t.string :type
      t.string :company
      t.integer :private_gist_count
      t.integer :owned_private_repo_count
      t.integer :followers_count
      t.integer :total_private_repo_count
      t.string :login
      t.string :email

      t.timestamps
    end
  end

  def self.down
    drop_table :github_users
  end
end
