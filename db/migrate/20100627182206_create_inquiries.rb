class CreateInquiries < ActiveRecord::Migration
  def self.up
    create_table :inquiries do |t|
      t.string :question
      t.string :audience
      t.integer :response_limit
      t.datetime :question_open
      t.datetime :question_closed
      t.timestamps
    end
  end

  def self.down
    drop_table :inquiries
  end
end
