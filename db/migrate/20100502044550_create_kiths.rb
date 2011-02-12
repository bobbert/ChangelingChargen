class CreateKiths < ActiveRecord::Migration
  def self.up
    create_table :kiths do |t|
      t.integer :seeming_id
      t.string :name

      t.timestamps
    end
  end

  def self.down
    drop_table :kiths
  end
end
