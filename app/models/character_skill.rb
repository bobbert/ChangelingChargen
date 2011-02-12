class CharacterSkill < ActiveRecord::Base
  belongs_to :character
  belongs_to :skill

  def <=>(other)
    cmp = (self.character.name <=> other.character.name)
    cmp = (self.skill.name <=> other.skill.name) unless cmp == 0
    cmp
  end

end
