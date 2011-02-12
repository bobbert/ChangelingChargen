class Skill < ActiveRecord::Base
  has_many :character_skills
  belongs_to :skill_type

end
