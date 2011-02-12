class Skill < ActiveRecord::Base
  has_many :character_skills
  belongs_to :skill_type

  def <=>(other)
    cmp = (self.skill_type <=> other.skill_type)
    cmp = (self.name <=> other.name) if (cmp == 0)
    cmp
  end
end
