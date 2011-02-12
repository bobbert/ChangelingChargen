# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110212195113) do

  create_table "character_contracts", :force => true do |t|
    t.integer  "character_id"
    t.integer  "contract_id"
    t.integer  "dots"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "specialty"
  end

  create_table "character_merits", :force => true do |t|
    t.integer  "character_id"
    t.integer  "merit_id"
    t.integer  "dots"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "specialty"
  end

  create_table "character_skills", :force => true do |t|
    t.integer  "character_id"
    t.integer  "skill_id"
    t.integer  "dots"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "specialty"
  end

  create_table "characters", :force => true do |t|
    t.string   "name"
    t.integer  "seeming_id"
    t.integer  "virtue_id"
    t.integer  "vice_id"
    t.integer  "court_id"
    t.integer  "wyrd"
    t.integer  "intelligence"
    t.integer  "wits"
    t.integer  "resolve"
    t.integer  "strength"
    t.integer  "dexterity"
    t.integer  "stamina"
    t.integer  "presence"
    t.integer  "manipulation"
    t.integer  "composure"
    t.integer  "size"
    t.integer  "clarity"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "title"
  end

  create_table "characters_kiths", :id => false, :force => true do |t|
    t.integer "character_id"
    t.integer "kith_id"
  end

  create_table "contracts", :force => true do |t|
    t.string   "name"
    t.boolean  "goblin"
    t.integer  "goblin_dots"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "supplemental"
  end

  create_table "courts", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "kiths", :force => true do |t|
    t.integer  "seeming_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "supplemental"
  end

  create_table "merits", :force => true do |t|
    t.integer  "min_dots"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "changeling"
    t.boolean  "supplemental"
    t.integer  "max_dots"
    t.string   "special_mod_stat"
    t.float    "special_modifier"
  end

  create_table "seemings", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "skill_types", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "skills", :force => true do |t|
    t.integer  "skill_type_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "vices", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "virtues", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
