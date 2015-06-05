class CreateGameboards < ActiveRecord::Migration
  def self.up
    create_table :gameboards do |t|
      t.datetime :start_time
      t.datetime :end_time
      t.integer :current_week
      t.timestamps
    end
  end

  def self.down
    drop_table :gameboards
  end
end
