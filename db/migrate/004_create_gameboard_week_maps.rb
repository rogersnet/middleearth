class CreateGameboardWeekMaps < ActiveRecord::Migration
  def self.up
    create_table :gameboard_week_maps do |t|
      t.integer :gameboard_id
      t.integer :week_number
      t.string :status
      t.datetime :start_time
      t.datetime :end_time
      t.timestamps
    end
  end

  def self.down
    drop_table :gameboard_week_maps
  end
end
