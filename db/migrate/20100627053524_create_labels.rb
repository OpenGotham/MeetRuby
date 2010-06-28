class CreateLabels < ActiveRecord::Migration
  def self.up
    create_table :labels do |t|
      t.string :title
      t.integer :source_id
      t.integer :topic_id
      t.float :ranking
      t.string :release
      t.date :release_date
      t.timestamps
    end
  end

  def self.down
    drop_table :labels
  end
end
