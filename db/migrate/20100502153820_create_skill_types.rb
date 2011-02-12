class CreateSkillTypes < ActiveRecord::Migration
  def self.up
    create_table :skill_types do |t|
      t.string :stype

      t.timestamps
    end
  end

  def self.down
    drop_table :skill_types
  end
end
