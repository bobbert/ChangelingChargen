class AddSpecialtiesToMeritsAndContracts < ActiveRecord::Migration
  def self.up
    add_column  :character_merits, :specialty, :string
    add_column  :merits, :changeling, :boolean
    add_column  :merits, :supplemental, :boolean
    add_column  :character_contracts, :specialty, :string
    add_column  :contracts, :supplemental, :boolean
    add_column  :kiths, :supplemental, :boolean
  end

  def self.down
    remove_column  :character_merits, :specialty
    remove_column  :merits, :changeling
    remove_column  :merits, :supplemental
    remove_column  :character_contracts, :specialty
    remove_column  :contracts, :supplemental
    remove_column  :kiths, :supplemental
  end
end
