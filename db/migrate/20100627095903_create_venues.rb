class CreateVenues < ActiveRecord::Migration
  def self.up
    create_table :venues do |t|
      t.string :name
      t.text :description
      t.string :street_address
      t.string :city
      t.string :state
      t.string :region
      t.string :postal_code
      t.text :instructions
      t.string :hours
      t.datetime :grand_opening
      t.datetime :grand_closing

      t.timestamps
    end
  end

  def self.down
    drop_table :venues
  end
end
