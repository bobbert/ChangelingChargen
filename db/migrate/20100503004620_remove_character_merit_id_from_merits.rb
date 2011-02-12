class RemoveCharacterMeritIdFromMerits < ActiveRecord::Migration
  def self.up
    remove_column :merits, :character_merit_id
  end

  def self.down
  end
end
