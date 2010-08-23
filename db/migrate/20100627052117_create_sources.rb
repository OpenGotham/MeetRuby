class CreateSources < ActiveRecord::Migration
  def self.up
    create_table :sources do |t|
      t.references :resourceful, :polymorphic => true
      t.string :title
      t.string :official_url
      t.string :primary_image_uid
      t.string :audience
      t.datetime :released
      t.timestamps
    end
    add_index :sources, :title, :unique => true
  end

  def self.down
    drop_table :sources
  end
end
