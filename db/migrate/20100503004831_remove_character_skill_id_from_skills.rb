class RemoveCharacterSkillIdFromSkills < ActiveRecord::Migration
  def self.up
    remove_column :skills, :character_skill_id
  end

  def self.down
  end
end
