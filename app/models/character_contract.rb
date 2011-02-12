class CharacterContract < ActiveRecord::Base
  belongs_to :character
  belongs_to :contract

  def <=>(other)
    cmp = (self.character.name <=> other.character.name)
    cmp = (self.contract.name <=> other.contract.name) unless cmp == 0
    cmp
  end

end
