class CharacterSkill < ActiveRecord::Base
  belongs_to :character
  belongs_to :skill
  
  validates_presence_of :character, :skill
  
  def skill_name
    skill && skill.name
  end
  
  def skill_name=(val)
    self.skill = Skill.find_by_name(val)
  end
  
  def character_name
    character && character.name
  end
  
  def to_s
    "Character:#{character.name} Skill:#{skill.name}"
  end

  def <=>(other)
    cmp = (self.character.name <=> other.character.name)
    cmp = (self.skill.name <=> other.skill.name) unless cmp == 0
    cmp
  end

end
