class SkillType < ActiveRecord::Base
  has_many :skills

  def <=>(other)
    self.name <=> other.name
  end
end
