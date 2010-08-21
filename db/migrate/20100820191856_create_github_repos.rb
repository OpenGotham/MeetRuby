class CreateGithubRepos < ActiveRecord::Migration
  def self.up
    create_table :github_repos do |t|
      t.integer :github_user_id
      t.integer :forks
      t.string :name
      t.integer :watchers
      t.boolean :private
      t.string :url
      t.boolean :fork
      t.string :owner
      t.string :homepage
      t.text :description

      t.timestamps
    end
  end

  def self.down
    drop_table :github_repos
  end
end
