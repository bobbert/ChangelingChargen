class Character < ActiveRecord::Base
  belongs_to :court
  has_and_belongs_to_many :kiths
  belongs_to :seeming
  belongs_to :vice
  belongs_to :virtue
  has_many :character_skills
  has_many :character_merits
  has_many :character_contracts

  validates_presence_of :seeming, :virtue, :vice

  attr_accessor :skills_to_add, :skill_dots_to_add, :skill_specialties_to_add
  attr_accessor :merits_to_add, :merit_dots_to_add, :merit_specialties_to_add
  attr_accessor :contracts_to_add, :contract_dots_to_add, :contract_specialties_to_add

  before_save :add_skills_and_merits_and_contracts

  MaxSkills = 20
  MaxContracts = 9
  MaxMerits = 9

  NumCoreStatRows = 9    # RWP: eliminate if/when application is sufficiently DRYed up

  AttributeList = [[:intelligence,:strength,:presence],
                   [:wits,:dexterity,:manipulation],
                   [:resolve,:stamina,:composure]
                  ]

  WyrdStats = { 1 => {:max_glamour => 10, :glamour_turn => 1, :attr_max => 5},
                2 => {:max_glamour => 11, :glamour_turn => 2, :attr_max => 5},
                3 => {:max_glamour => 12, :glamour_turn => 3, :attr_max => 5},
                4 => {:max_glamour => 13, :glamour_turn => 4, :attr_max => 5},
                5 => {:max_glamour => 14, :glamour_turn => 5, :attr_max => 5},
                6 => {:max_glamour => 15, :glamour_turn => 6, :attr_max => 6},
                7 => {:max_glamour => 20, :glamour_turn => 7, :attr_max => 7},
                8 => {:max_glamour => 30, :glamour_turn => 8, :attr_max => 8},
                9 => {:max_glamour => 50, :glamour_turn => 10, :attr_max => 9},
                10 => {:max_glamour => 100, :glamour_turn => 15, :attr_max => 10}
              }

  # --- Derived Stats ---

  def willpower
    composure + resolve
  end

  def initiative
    dexterity + composure
  end

  def health
    stamina + size
  end

  def defense
    # lowest of two stats
    (wits > dexterity) ? dexterity : wits
  end

  def speed
    strength + dexterity + 5
  end

  # --- "Safe" access methods ---

  def court_name
    court.blank? ? 'Courtless' : court.name
  end

  def formatted_kiths
    return "None" if kiths.blank?
    return kiths.map {|k| k.name }.join(' / ')
  end
  
  # --- Many-to-many association mappings ---

  def skills
   character_skills.map {|cs| cs.skill }
  end

  def merits
   character_merits.map {|cm| cm.merit }
  end

  def contracts
   character_contracts.map {|cc| cc.contract }
  end

  # --- Derived from Wyrd Stats ---

  def max_glamour
    return 0 unless (1..10).include? wyrd
    WyrdStats[wyrd][:max_glamour]
  end

  def glamour_turn
    return 0 unless (1..10).include? wyrd
    WyrdStats[wyrd][:glamour_turn]
  end

  def attr_max
    return 0 unless (1..10).include? wyrd
    WyrdStats[wyrd][:attr_max]
  end

  def glamour_stats
    "#{max_glamour} / #{glamour_turn}"
  end

  # --- Methods based on virtual attributes ---

  # returns largest number among the three rows: [1] Skills, [2] Contracts + Merits, [3] Core Stats
  def num_table_rows
    largest_num_rows = NumCoreStatRows
    (csl,ccml) = [character_skills.length, (1 + character_merits.length + character_contracts.length)]
    [csl,ccml].each {|num| largest_num_rows = num if num > largest_num_rows }
    largest_num_rows
  end

  # adds all new Skills, Merits, and Contracts to character
  def add_skills_and_merits_and_contracts
    [:skill,:merit,:contract].each do |category_type|
      h = get_smc_constant_names(category_type)
      (add_category, add_dots, add_speclty) = ["#{h[:plural]}_to_add", "#{category_type.to_s}_dots_to_add", 
                                               "#{category_type.to_s}_specialties_to_add"]
      
      # iterating (max_constant) number of times
      instance_eval(h[:max_constant]).times do |n|
        unless self.send(add_category)[n].blank? || self.send(add_dots)[n].blank?
          category = instance_eval(h[:class]).find( self.send(add_category)[n].to_i )
          assoc = instance_eval(h[:assoc_class]).create( :dots => self.send(add_dots)[n].to_i, :specialty => self.send(add_speclty)[n].to_s )
          category.send("character_#{h[:plural]}") <<  assoc
          self.send("character_#{h[:plural]}") <<  assoc
        end
      end
    end
  end

private

  # gets constant names for ActiveRecord
  def get_smc_constant_names( name )
    (sing_form, plural_form) = [name.to_s, name.to_s.pluralize]
    { :max_constant => "Max#{plural_form.titlecase}",
      :class => sing_form.titlecase,
      :plural => plural_form,
      :assoc_class => "Character#{sing_form.titlecase}" }
  end
  
end
