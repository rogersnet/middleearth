class AddDemandPackageToGameBoardWeekMap < ActiveRecord::Migration
  def self.up
    add_column :gameboard_week_maps, :demand_package_id, :integer
  end

  def self.down
    remove_column :gameboard_week_maps, :demand_package_id
  end
end
