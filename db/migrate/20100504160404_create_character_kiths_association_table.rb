class CreateCharacterKithsAssociationTable < ActiveRecord::Migration
  def self.up
    create_table :characters_kiths, :id => false do |t|
      t.integer :character_id
      t.integer :kith_id
    end
    remove_column :characters, :kith_id
  end

  def self.down
    drop_table :characters_kiths
  end
end
