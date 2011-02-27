module CharactersHelper

  EmptyElement = ' '

  def num_to_dots(num, use_html_entity = true)
    dot_string = ""
    dot = (use_html_entity ? "&bull;" : "•")
    num.times {|n| dot_string += (' ' if ((n % 5 == 0) && (n > 0))).to_s + dot }
    dot_string
  end
  
  def num_to_dot_chars(num)
    num_to_dots(num, false)
  end

  def render_character_merit(char_merit, is_form = false)
    if is_form
      char_merit_html = "<p class=\"item\"><span class=\"merit-id\" style=\"display:none;\">#{(char_merit.id if char_merit).to_s}</span>"
      char_merit_html += select_tag "character[merits_to_add][]", options_for_select( [['','']] + Merit.find(:all).map {|s| [s.name,s.id] }, (char_merit.merit.id if char_merit) ), :class => 'merit-type'
    	char_merit_html += select_tag "character[merit_dots_to_add][]", options_for_select([['','']] + (dot_range_select_list(1,5) if char_merit).to_a, (char_merit.dots if char_merit)), :class => 'merit-dots'
    	char_merit_html += text_field_tag("character[merit_specialties_to_add][]", (char_merit.specialty if char_merit), :maxlength => 50, :class => 'specialty-type') + "</p>"
    else
      return EmptyElement if char_merit.blank?
      char_merit_html = "<b style=\"color:darkgreen;\">#{char_merit.merit.name}</b> #{add_parens_if_exists(char_merit.specialty)} #{num_to_dots(char_merit.dots)}"
    end
    return char_merit_html
  end

  def render_all_merits_for_char(char, is_form = false)
    char.character_merits.map {|cm| render_character_merit(cm,is_form) }.join('<br />')
  end

  def render_character_skill(char_skill, is_form = false)
    if is_form
      char_skill_html = "<p class=\"item\"><span class=\"skill-id\" style=\"display:none;\">#{(char_skill.id if char_skill).to_s}</span>"
      char_skill_html += select_tag "character[skills_to_add][]", options_for_select( [['','']] + Skill.find(:all).map {|s| [s.name,s.id] }, (char_skill.skill.id if char_skill) ), :class => 'skill-type'
    	char_skill_html += select_tag "character[skill_dots_to_add][]", options_for_select([['','']] + (dot_range_select_list(1,5) if char_skill).to_a, (char_skill.dots if char_skill)), :class => 'skill-dots'
    	char_skill_html += text_field_tag("character[skill_specialties_to_add][]", (char_skill.specialty if char_skill), :maxlength => 50, :class => 'specialty-type') + "</p>"
    else
      return EmptyElement if char_skill.blank?
      char_skill_html = "<b style=\"color:darkgreen;\">#{char_skill.skill.name}</b> #{add_parens_if_exists(char_skill.specialty)} #{num_to_dots(char_skill.dots)}"
    end
    return char_skill_html
  end

  def render_all_skills_for_char(char, is_form = false)
     char.character_skills.map {|cs| render_character_skill(cs,is_form) }.join('<br />')
  end

  def render_character_contract(char_contract, is_form = false)
    if is_form
      char_contract_html = "<p class=\"item\"><span class=\"contract-id\" style=\"display:none;\">#{(char_contract.id if char_contract).to_s}</span>"
      char_contract_html += select_tag "character[contracts_to_add][]", options_for_select( [['','']] + Contract.find(:all).map {|s| [s.name,s.id] }, (char_contract.contract.id if char_contract) ), :class => 'contract-type'
    	char_contract_html += select_tag "character[contract_dots_to_add][]", options_for_select([['','']] + (dot_range_select_list(1,5) if char_contract).to_a, (char_contract.dots if char_contract)), :class => 'contract-dots'
    	char_contract_html += text_field_tag("character[contract_specialties_to_add][]", (char_contract.specialty if char_contract), :maxlength => 50, :class => 'specialty-type') + "</p>"
    else
      return EmptyElement if char_contract.blank?
      # "Goblin" if goblin contract; specialty type otherwise
      spec_lbl = (char_contract.contract.goblin? ? '(Goblin)' : add_parens_if_exists(char_contract.specialty) ).to_s
      char_contract_html = "<b style=\"color:darkgreen;\">#{char_contract.contract.name}</b> #{spec_lbl} #{num_to_dots(char_contract.dots)}"
    end
    return char_contract_html
  end

  def render_all_contracts_for_char(char, is_form = false)
     char.character_contracts.map {|cc| render_character_contract(cc,is_form) }.join('<br />')
  end

  def render_all_core_stats_for_char(char, is_form = false)
    if is_form
      corestats = [ ['Wyrd', select(:character, :wyrd, (1..10).to_a.map {|n| [num_to_dot_chars(n), n] }, {}, :class => 'core-stat') ],
                    ['Glamour / Per Turn:', (char.glamour_stats if char).to_s],
                    ['Health:', (char.health if char).to_s],
                    ['Willpower:', (char.willpower if char).to_s],
                    ['Clarity:', select(:character, :clarity, (1..10).to_a.map {|n| [n, n] }, {}, :class => 'core-stat') ],
                    ['Initiative:', (char.initiative if char).to_s],
                    ['Defense:', (char.defense if char).to_s],
                    ['Size:', (char.true_size if char).to_s],
                    ['Speed:', (char.speed if char).to_s] ]
    else
      corestats = [ ['Wyrd', num_to_dots( char.wyrd )],
                    ['Glamour / Per Turn:', char.glamour_stats],
                    ['Health:', char.health.to_s],
                    ['Willpower:', char.willpower.to_s],
                    ['Clarity:', char.clarity.to_s],
                    ['Initiative:', char.initiative.to_s],
                    ['Defense:', char.defense.to_s],
                    ['Size:', char.true_size.to_s],
                    ['Speed:', char.speed.to_s] ]
    end

    corestats.map {|cs_arr| "<b style=\"color:darkgreen;\">#{cs_arr[0]}</b> #{cs_arr[1]}" }.join('<br />')
  end
  
  # adds enclosing parens to non-null objects
  def add_parens_if_exists(obj)
    str = obj.blank? ? '' : "(#{obj.to_s})"
  end
  
  def dot_range_list(min_dots = 1, max_dots = 5, use_html_entity = true)
    (min_dots..max_dots).to_a.map {|n| [n, num_to_dots(n)] }
  end

  def dot_range_select_list(min_dots = 1, max_dots = 5)
    (min_dots..max_dots).to_a.map {|n| [num_to_dots(n, false), n] }
  end

end