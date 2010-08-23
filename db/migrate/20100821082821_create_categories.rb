class CreateCategories < ActiveRecord::Migration
  def self.up
    create_table :categories do |t|
      t.string :name
      t.text :description
      t.string :ancestry

      t.timestamps
    end
    create_table :categories_sources, :id => false  do |t|
      t.integer :source_id
      t.integer :category_id

      t.timestamps
    end
  end

  def self.down
    drop_table :categories
  end
end
