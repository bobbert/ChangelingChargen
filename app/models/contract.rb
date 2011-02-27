class Contract < ActiveRecord::Base
  has_many :character_contracts

  # adding question-mark routine for extra Ruby flavor
  def goblin?
    goblin
  end

end
