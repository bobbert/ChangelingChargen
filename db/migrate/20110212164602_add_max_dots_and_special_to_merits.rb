class AddMaxDotsAndSpecialToMerits < ActiveRecord::Migration
  def self.up
    add_column :merits, :max_dots, :integer
    add_column :merits, :special_mod_stat, :string
    add_column :merits, :special_modifier, :float
    rename_column :merits, :default_dots, :min_dots
  end

  def self.down
    rename_column :merits, :min_dots, :default_dots
    remove_column :merits, :special_modifier
    remove_column :merits, :special_mod_stat
    remove_column :merits, :max_dots
  end
end
