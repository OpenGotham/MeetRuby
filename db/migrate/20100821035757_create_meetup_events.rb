class CreateMeetupEvents < ActiveRecord::Migration
  def self.up
    create_table :meetup_events do |t|
      t.integer :event_id
      t.integer :meetup_event_id
      t.string :name
      t.text :description
      t.string :event_url
      t.datetime :time

      t.timestamps
    end
    add_index :meetup_events, :meetup_event_id,   :unique => true
  end

  def self.down
    drop_table :meetup_events
  end
end
