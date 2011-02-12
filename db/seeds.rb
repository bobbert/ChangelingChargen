# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

CourtTypes = [:spring,:summer,:autumn,:winter, :courtless]
SeemingTypes = [:beast,:darkling,:elemental,:fairest,:ogre,:wizened]
ViceTypes = [:envy,:gluttony,:greed,:lust,:pride,:sloth,:wrath]
VirtueTypes = [:charity,:faith,:fortitude,:hope,:justice,:prudence,:temperance]

KithTypes = {:beast => [:broadback,:hunterheart,:runnerswift,:skitterskulk,:steepscrambler,:swimmerskin,:venombite,:windwing], 
             :darkling => [:antiquarian,:gravewight,:leechfinger,:mirrorskin,:tunnelgrub],
             :elemental => [:airtouched,:earthbones,:fireheart,:manikin,:snowskin,:waterborn,:woodblood],
             :fairest => [:bright_one,:dancer,:draconic,:flowering,:muse],
             :ogre => [:cyclopean,:farwalker,:gargantuan,:gristlegrinder,:stonebones,:waterdweller],
             :wizened => [:artist,:brewer,:chatelaine,:chirurgeon,:oracle,:smith,:soldier] 
}
SupplementalKithTypes = {:beast => [:cleareyes,:coldscale,:roteater,:truefriend,:chimera,:coyote,:nix], 
                         :darkling => [:lurkglider,:moonborn,:nightsinger,:palewraith,:razorhand,:whisperwisp,:illes,:pishacha,:skogsra],
                         :elemental => [:blightbent,:levinquick,:metalflesh,:sandharrowed,:apsaras,:ask_wee_da_eed,:di_cang],
                         :fairest => [:flamesiren,:polychromatic,:shadowsoul,:telluric,:treasured,:gandharva,:succubus,:weisse_frau],
                         :ogre => [:bloodbrute,:corpsegrinder,:render,:witchtooth,:daitya,:oni,:troll],
                         :wizened => [:author,:drudge,:gameplayer,:miner,:gremlin,:pamarindo,:thusser] 
}

Court.find(:all).each {|c| c.destroy }
Seeming.find(:all).each {|st| st.destroy }
Vice.find(:all).each {|v| v.destroy }
Virtue.find(:all).each {|v| v.destroy }

CourtTypes.each {|court| Court.create( :name => court.to_s.titlecase ) }
SeemingTypes.each {|seeming| Seeming.create( :name => seeming.to_s.titlecase ) }
ViceTypes.each {|vice| Vice.create( :name => vice.to_s.titlecase ) }
VirtueTypes.each {|virtue| Virtue.create( :name => virtue.to_s.titlecase ) }

Kith.find(:all).each {|k| k.destroy }

SeemingTypes.each do |seeming_parent_type|
  s = Seeming.find_by_name( seeming_parent_type.to_s.titlecase )
  KithTypes[seeming_parent_type].each do |kith|
    k = Kith.create( :name => kith.to_s.titlecase, :supplemental => false )
    k.seeming = s
    k.save
  end
  SupplementalKithTypes[seeming_parent_type].each do |kith|
    k = Kith.create( :name => kith.to_s.titlecase, :supplemental => true )
    k.seeming = s
    k.save
  end
end

# --- Skills --- #

SkillsByType = { :mental => [:academics,:computer,:crafts,:investigation,:medicine,:occult,:politics,:science], 
                 :physical => [:athletics,:brawl,:drive,:firearms,:larceny,:stealth,:survival,:weaponry], 
                 :social => [:animal_ken,:empathy,:expression,:intimidation,:persuasion,:socialize,:streetwise,:subterfuge]
}
OrderedSkillTypes = [:mental, :physical, :social]

SkillType.find(:all).each {|st| st.destroy }
Skill.find(:all).each {|sk| sk.destroy }

OrderedSkillTypes.each do |skill_type|
  skills = SkillsByType[skill_type]
  st = SkillType.create( :name => skill_type.to_s.titlecase )
  skills.each do |skill|
    s = Skill.create( :name => skill.to_s.titlecase )
    s.skill_type = st
    s.save
  end
end

# --- Merits --- #

BasicMerits = [['Common Sense',4,4],['Danger Sense',2,2],['Eidetic Memory',2,2],['Encyclopedic Knowledge',4,4],
               ['Holistic Awareness',3,3],['Language',1,5],['Meditative Mind',1,1],['Unseen Sense',3,3],
               ['Ambidextrous',3,3],['Brawling Dodge',1,1], ['Direction Sense',1,1],['Disarm',2,2],['Fast Reflexes',1,2],['Fighting Finesse',2,2],
               ['Boxing'],['Kung Fu'],['Two Weapons',1,4],['Fleet of Foot',1,3],['Fresh Start',1,1],['Giant',4,4],['Gunslinger',3,3],['Iron Stamina',1,3],
               ['Iron Stomach',2,2],['Natural Immunity',1,1],['Quickdraw',1,1],['Quick Healer',4,4],['Strong Back',1,1],['Strong Lungs',3,3],
               ['Stunt Driver',3,3],['Toxin Resistance',2,2],['Weaponry Dodge',1,1],
               ['Allies'],['Barfly',1,1],['Contacts'],['Fame',1,3],['Inspiring',4,4],
               ['Mentor'],['Resources'],['Retainer'],['Status'],['Striking Looks',2,4]]

ChangelingMerits = [['Court Goodwill: Spring'],['Court Goodwill: Summer'],['Court Goodwill: Autumn'],['Court Goodwill: Winter'],['Harvest'],
                    ['Hollow'],['Mantle: Spring'],['Mantle: Summer'],['Mantle: Autumn'],['Mantle: Winter'],['New Identity',1,4],['Token']]
                     
SupplementalMerits = [['Arcadian Body',4,4],['Arcadian Metabolism',3,3],['Archive'],['Brownie\'s Boon',1,1],['Charmed Life',2,2],['Dual Kith',3,3],
                      ['Enchanting Performance',4,4],['Fae Mount'],['Faerie Favor',3,3],['Faerie Healing',2,2],['Fighting Style: Dream Combat'],
                      ['Fighting Style: Hedge Duelist'],['Gentrified Bearing',4,4],['Hedge Gate Sense',1,1],['Hidden Life',1,3],['Hob Kin',2,2],
                      ['Hobgoblin Trainer',2,2],['Lethal Mien',2,2],['Long of Days',2,2],['Market Sense',1,1],['Perfect Stillness',1,1],['Pledgesmith',1,3],
                      ['Prophet Circle'],['Rigid Mask',2,2],['Ritual Doorway',3,3],['Siren Song',3,3],['Soul Sense',2,2],['Visionary Dreams',2,2],
                      ['Wisdom of Dreams',3,3],['Workshop'],['Hedge Beast Companion',1,3]]

MeritSpecialModifiers = {
    'Fast Reflexes' => ['Initiative', 1],
    'Fleet of Foot' => ['Speed', 1],
    'Giant' => ['Size', 0.25],
    'Mantle: Summer' => ['Health', 0.2],
}

Merit.find(:all).each {|m| m.destroy }

BasicMerits.each do |merit_arr|
  Merit.create( :name => merit_arr[0], :min_dots => (merit_arr[1] || 1), :max_dots => (merit_arr[2] || 5), :changeling => false, :supplemental => false )
end
ChangelingMerits.each do |merit_arr|
  Merit.create( :name => merit_arr[0], :min_dots => (merit_arr[1] || 1), :max_dots => (merit_arr[2] || 5), :changeling => true, :supplemental => false )
end
SupplementalMerits.each do |merit_arr|
  Merit.create( :name => merit_arr[0], :min_dots => (merit_arr[1] || 1), :max_dots => (merit_arr[2] || 5), :changeling => true, :supplemental => true )
end

MeritSpecialModifiers.each do |merit, special_mods|
  m = Merit.find_by_name(merit)
  m.special_mod_stat = special_mods[0].downcase
  m.special_modifier = special_mods[1].to_f
  m.save
end

# --- Contracts --- #

ContractTypes = ['Dream','Hearth','Mirror','Smoke','Artifice','Darkness','Elements','Fang and Talon','Stone','Vainglory',
                 'Fleeting Spring','Eternal Spring','Fleeting Summer','Eternal Summer',
                 'Fleeting Autumn','Eternal Autumn','Fleeting Winter','Eternal Winter']

GoblinContracts = [['Trading Luck for Fate',1],['Shooter\'s Bargain',1],['Diviner\'s Madness',2],['Fair Entrance',2],['Fool\'s Gold',2],
                   ['Burden of Life',3],['Delayed Harm',3],['Good and Bad Luck',4],['Call the Hunt',4],['Lost and Found',5]]

SupplementalContractTypes = ['Den','Shade and Spirit','Communion','Separation','Oath and Punishment','Animation','Forge','Hours','Moon','Omen','Wild',
                             'Verdant Spring','Punishing Summer','Spell-bound Autumn','Sorrow-Frozen Heart']

SupplementalGoblinContracts = [['Sight of Truth and Lies',1],['Calling the Guardian',2],['The Blessing of Forgetfulness',3],['Goblin Oath',4],
                               ['Blood-binding',5],['Fortune\'s Favor',1],['Fortune\'s Swift Blessing',2],['Fortune\'s Bane',3],['Distracting the Hounds',3],
                               ['Recalling the Lost',5],['Healing Sacrifice',1],['Seven-Year Gift',2],['Trading Beauty for Love',3],['Changing Minds',4],
                               ['The Fatal Transformation',5]]

Contract.find(:all).each {|c| c.destroy }

ContractTypes.each do |contract|
  Contract.create( :name => contract, :goblin => false, :supplemental => false )
end
GoblinContracts.each do |gc_arr|
  Contract.create( :name => gc_arr[0], :goblin => true, :goblin_dots => gc_arr[1], :supplemental => false )
end
SupplementalContractTypes.each do |contract|
  Contract.create( :name => contract, :goblin => false, :supplemental => true )
end
SupplementalGoblinContracts.each do |gc_arr|
  Contract.create( :name => gc_arr[0], :goblin => true, :goblin_dots => gc_arr[1], :supplemental => true )
end

