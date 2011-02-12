class CharacterMerit < ActiveRecord::Base
  belongs_to :character
  belongs_to :merit

  # returns the special attribute modifier for this merit and the attribute passed in, if applicable
  def special_modifier(attrib)
    return 0 unless (merit.special_mod_stat && (merit.special_mod_stat.to_s.downcase == attrib.to_s.downcase))
    return (dots.to_f * merit.special_modifier).floor
  end

  def to_s
    "Character:#{character.name} Merit:#{merit.name}"
  end

  def <=>(other)
    cmp = (self.character.name <=> other.character.name)
    cmp = (self.merit.name <=> other.merit.name) unless cmp == 0
    return cmp
  end

end
