class CreateCostSheets < ActiveRecord::Migration
  def self.up
    create_table :cost_sheets do |t|
      t.integer :gameboard_id
      t.timestamps
    end
  end

  def self.down
    drop_table :cost_sheets
  end
end
