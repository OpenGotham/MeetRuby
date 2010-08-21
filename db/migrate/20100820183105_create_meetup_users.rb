class CreateMeetupUsers < ActiveRecord::Migration
  def self.up
    create_table :meetup_users do |t|
      t.integer :user_id
      t.string :api_key

      t.timestamps
    end
  end

  def self.down
    drop_table :meetup_users
  end
end
