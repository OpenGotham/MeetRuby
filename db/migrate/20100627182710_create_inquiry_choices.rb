class CreateInquiryChoices < ActiveRecord::Migration
  def self.up
    create_table :inquiry_choices do |t|
      t.string :option_copy
      t.string :option_value

      t.timestamps
    end
  end

  def self.down
    drop_table :inquiry_choices
  end
end
