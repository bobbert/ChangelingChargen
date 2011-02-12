class ChangeSkillTypeFieldFromStypeToName < ActiveRecord::Migration
  def self.up
    rename_column :skill_types, :stype, :name
  end

  def self.down
    rename_column :skill_types, :name, :stype
  end
end
