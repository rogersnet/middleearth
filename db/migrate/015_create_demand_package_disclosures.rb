class CreateDemandPackageDisclosures < ActiveRecord::Migration
  def self.up
    create_table :demand_package_disclosures do |t|
      t.integer :total_demand_estimate
      t.timestamps
    end
  end

  def self.down
    drop_table :demand_package_disclosures
  end
end
