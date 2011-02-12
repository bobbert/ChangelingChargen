module CharactersHelper

  EmptyElement = ' '

  def num_to_dots( num )
    dot_string = ""
    num.times {|n| dot_string += (' ' if n%5==0 && n>0).to_s + "&bull;" }
    dot_string
  end

  def render_character_merit( char_merit )
    return EmptyElement if char_merit.blank?
    cm_spec = add_parens_if_exists(char_merit.specialty)
    return "<td><label>#{char_merit.merit.name}</label> #{cm_spec} #{num_to_dots(char_merit.dots)}</td>"
  end

  # returns an array of all HTML-rendered merits for character passed in
  def render_all_merits_for_char( char )
    char.character_merits.map {|cm| render_character_merit(cm) }
  end

  def render_character_skill( char_skill )
    return EmptyElement if char_skill.blank?
    cs_spec = add_parens_if_exists(char_skill.specialty)
    return "<td><label>#{char_skill.skill.name}</label> #{cs_spec} #{num_to_dots(char_skill.dots)}</td>"
  end

  def render_all_skills_for_char( char )
     char.character_skills.map {|cs| render_character_skill(cs) }
  end

  def render_character_contract( char_contract )
    return EmptyElement if char_contract.blank?
    # "Goblin" if goblin contract; specialty type otherwise
    spec_lbl = (char_contract.contract.goblin ? '(Goblin)' : add_parens_if_exists(char_contract.specialty) ).to_s
    return "<td><label>#{char_contract.contract.name}</label> #{spec_lbl} #{num_to_dots(char_contract.dots)}</td>"
  end

  def render_all_contracts_for_char( char )
     char.character_contracts.map {|cs| render_character_contract(cs) }
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

    corestats.map {|cs_arr| "<td><label>#{cs_arr[0]}</label> #{cs_arr[1]}</td>" }
  end
  
  # adds enclosing parens to non-null objects
  def add_parens_if_exists( obj )
    str = obj.blank? ? '' : "(#{obj.to_s})"
  end

end