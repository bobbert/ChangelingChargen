class CharacterMerit < ActiveRecord::Base
  belongs_to :character
  belongs_to :merit

  def <=>(other)
    cmp = (self.character.name <=> other.character.name)
    cmp = (self.merit.name <=> other.merit.name) unless cmp == 0
    cmp
  end

end
