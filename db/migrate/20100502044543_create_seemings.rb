class CreateSeemings < ActiveRecord::Migration
  def self.up
    create_table :seemings do |t|
      t.string :name

      t.timestamps
    end
  end

  def self.down
    drop_table :seemings
  end
end
