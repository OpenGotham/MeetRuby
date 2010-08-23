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
    add_index :github_repos, :name, :unique => true
  end

  def self.down
    drop_table :github_repos
  end
end
