class AddDemandPackageDisclosureToWeekMap < ActiveRecord::Migration
  def self.up
    add_column :gameboard_week_maps, :demand_package_disclosure_id, :integer
  end

  def self.down
    remove_column :gameboard_week_maps, :demand_package_disclosure_id
  end
end
