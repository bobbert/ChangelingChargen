module CharactersHelper

  EmptyElement = ' '

  def num_to_dots( num )
    dot_string = ""
    num.times {|n| dot_string += (' ' if ((n % 5 == 0) && (n > 0))).to_s + "&bull;" }
    dot_string
  end
  
  def num_to_dot_chars( num )
    num_to_dots(num).gsub(/\&bull\;/, "•")
  end

  def render_character_merit( char_merit )
    return EmptyElement if char_merit.blank?
    cm_spec = add_parens_if_exists(char_merit.specialty)
    return "<b style=\"color:darkgreen;\">#{char_merit.merit.name}</b> #{cm_spec} #{num_to_dots(char_merit.dots)}"
  end

  def render_all_merits_for_char( char )
    char.character_merits.map {|cm| render_character_merit(cm) }.join('<br />')
  end

  def render_character_skill( char_skill )
    return EmptyElement if char_skill.blank?
    cs_spec = add_parens_if_exists(char_skill.specialty)
    return "<b style=\"color:darkgreen;\">#{char_skill.skill.name}</b> #{cs_spec} #{num_to_dots(char_skill.dots)}"
  end

  def render_all_skills_for_char( char )
     char.character_skills.map {|cs| render_character_skill(cs) }.join('<br />')
  end

  def render_character_contract( char_contract )
    return EmptyElement if char_contract.blank?
    # "Goblin" if goblin contract; specialty type otherwise
    spec_lbl = (char_contract.contract.goblin ? '(Goblin)' : add_parens_if_exists(char_contract.specialty) ).to_s
    return "<b style=\"color:darkgreen;\">#{char_contract.contract.name}</b> #{spec_lbl} #{num_to_dots(char_contract.dots)}"
  end

  def render_all_contracts_for_char( char )
     char.character_contracts.map {|cs| render_character_contract(cs) }.join('<br />')
  end

  def render_all_core_stats_for_char( char )
    corestats = [ ['Wyrd', num_to_dots( char.wyrd )],
                  ['Glamour / Per Turn:', char.glamour_stats],
                  ['Health:', char.health.to_s],
                  ['Willpower:', char.willpower.to_s],
                  ['Clarity:', char.clarity.to_s],
                  ['Initiative:', char.initiative.to_s],
                  ['Defense:', char.defense.to_s],
                  ['Size:', char.true_size.to_s],
                  ['Speed:', char.speed.to_s] ]

    corestats.map {|cs_arr| "<b style=\"color:darkgreen;\">#{cs_arr[0]}</b> #{cs_arr[1]}" }.join('<br />')
  end
  
  # adds enclosing parens to non-null objects
  def add_parens_if_exists( obj )
    str = obj.blank? ? '' : "(#{obj.to_s})"
  end
  
  def dot_range_list(min_dots = 1, max_dots = 5)
    (min_dots..max_dots).to_a.map {|n| [n,num_to_dots(n)] }
  end

end