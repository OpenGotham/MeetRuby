class CreateAuthors < ActiveRecord::Migration
  def self.up
    create_table :authors do |t|
      t.integer :source_id
      t.integer :profile_id

      t.timestamps
    end
  end

  def self.down
    drop_table :authors
  end
end
