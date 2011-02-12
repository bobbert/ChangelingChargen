class AddSpecialtyToCharacterSkills < ActiveRecord::Migration
  def self.up
    add_column  :character_skills, :specialty, :string
  end

  def self.down
  end
end
