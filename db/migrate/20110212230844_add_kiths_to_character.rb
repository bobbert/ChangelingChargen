class AddKithsToCharacter < ActiveRecord::Migration
  def self.up
    add_column :characters, :kith_id, :integer
    add_column :characters, :second_kith_id, :integer
    drop_table :characters_kiths
  end

  def self.down
    create_table :characters_kiths  # table with only id field
    remove_column :characters, :second_kith_id
    remove_column :characters, :kith_id
  end
end
