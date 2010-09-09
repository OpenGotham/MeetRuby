class CreateBooks < ActiveRecord::Migration
  def self.up
    create_table :books do |t|
      t.string :title
      t.string :subtitle
      t.text :description
      t.date :print_date
      t.string :isbn
      t.string :edition
      t.string :publisher
      t.string :source_code_url

      t.timestamps
    end
    add_index :books, :title, :unique => true
    add_index :books, :isbn, :unique => true
  end

  def self.down
    drop_table :books
  end
end
