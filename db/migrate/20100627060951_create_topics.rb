class CreateTopics < ActiveRecord::Migration
  def self.up
    create_table :topics do |t|
      t.integer :supertopic_id
      t.string :name
      t.string :github_url
      t.string :rubyforge_url
      t.string :rubygem_url
      t.string :rdoc_url
      t.string :toolbox_category
      t.text :description
      
      t.timestamps
    end
  end

  def self.down
    drop_table :topics
  end
end
