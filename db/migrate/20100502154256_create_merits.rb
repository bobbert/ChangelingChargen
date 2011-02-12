class CreateMerits < ActiveRecord::Migration
  def self.up
    create_table :merits do |t|
      t.integer :character_merit_id
      t.integer :default_dots
      t.string :name

      t.timestamps
    end
  end

  def self.down
    drop_table :merits
  end
end
