class Virtue < ActiveRecord::Base
  has_many :characters

  def <=>(other)
    self.name <=> other.name
  end
end
