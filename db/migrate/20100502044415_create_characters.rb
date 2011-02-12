class CreateCharacters < ActiveRecord::Migration
  def self.up
    create_table :characters do |t|
      t.string :name
      t.integer :seeming_id
      t.integer :kith_id
      t.integer :virtue_id
      t.integer :vice_id
      t.integer :court_id
      t.integer :wyrd
      t.integer :intelligence
      t.integer :wits
      t.integer :resolve
      t.integer :strength
      t.integer :dexterity
      t.integer :stamina
      t.integer :presence
      t.integer :manipulation
      t.integer :composure
      t.integer :size
      t.integer :clarity

      t.timestamps
    end
  end

  def self.down
    drop_table :characters
  end
end
