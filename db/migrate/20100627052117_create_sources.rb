class CreateSources < ActiveRecord::Migration
  def self.up
    create_table :sources do |t|
      t.references :resourceful, :polymorphic => true
      t.string :title
      t.string :official_url
      t.string :primary_image_url
      t.string :primary_image_uid
      t.string :audience
      t.timestamps
    end
  end

  def self.down
    drop_table :sources
  end
end
