class CreateProfiles < ActiveRecord::Migration
  def self.up
    create_table :profiles do |t|
      t.integer :user_id
      t.string :full_name
      t.string :first_name
      t.string :last_name
      t.date :birthday
      t.text :overview
      t.string :github_url
      t.string :rubyforge_url
      t.string :workingwithrails_url
      t.string :blog_url
      t.string :twitter_url
      t.string :facebook_url
      t.timestamps
    end
  end

  def self.down
    drop_table :profiles
  end
end
