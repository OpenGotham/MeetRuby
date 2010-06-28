class CreateWorkItems < ActiveRecord::Migration
  def self.up
    create_table :work_items do |t|
      t.string :title
      t.text :description
      t.integer :estimated_hours
      t.float :low_rate
      t.float :high_rate
      t.string :rate_scale
      t.string :work_license

      t.timestamps
    end
  end

  def self.down
    drop_table :work_items
  end
end
