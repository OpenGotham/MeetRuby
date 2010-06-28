class CreateEvents < ActiveRecord::Migration
  def self.up
    create_table :events do |t|
      t.string :title
      t.integer :venue_id
      t.text :description
      t.datetime :start_time
      t.datetime :end_time
      t.string :organization

      t.timestamps
    end
  end

  def self.down
    drop_table :events
  end
end
