class CreatePrices < ActiveRecord::Migration
  def self.up
    create_table :prices do |t|
      t.integer :source_id
      t.string :rate_name
      t.float :price
      t.text :description
      t.boolean :set_rate
      t.string :group_rate
      t.datetime :rate_start
      t.datetime :rate_end

      t.timestamps
    end
  end

  def self.down
    drop_table :prices
  end
end
