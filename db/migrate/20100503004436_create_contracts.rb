class CreateContracts < ActiveRecord::Migration
  def self.up
    create_table :contracts do |t|
      t.string :name
      t.boolean :goblin
      t.integer :goblin_dots

      t.timestamps
    end
  end

  def self.down
    drop_table :contracts
  end
end
