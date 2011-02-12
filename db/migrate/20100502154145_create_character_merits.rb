class CreateCharacterMerits < ActiveRecord::Migration
  def self.up
    create_table :character_merits do |t|
      t.integer :character_id
      t.integer :merit_id
      t.integer :dots

      t.timestamps
    end
  end

  def self.down
    drop_table :character_merits
  end
end
