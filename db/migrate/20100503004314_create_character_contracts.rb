class CreateCharacterContracts < ActiveRecord::Migration
  def self.up
    create_table :character_contracts do |t|
      t.integer :character_id
      t.integer :contract_id
      t.integer :dots

      t.timestamps
    end
  end

  def self.down
    drop_table :character_contracts
  end
end
