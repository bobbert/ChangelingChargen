class AddTitleToCharacter < ActiveRecord::Migration
  def self.up
    add_column :characters, :title, :string
  end

  def self.down
  end
end
