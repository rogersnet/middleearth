class CreateDemandPackageDisclosureSegments < ActiveRecord::Migration
  def self.up
    create_table :demand_package_disclosure_segments do |t|
      t.integer :demand_package_disclosure_id
      t.string :segment
      t.integer :demand_size
      t.timestamps
    end
  end

  def self.down
    drop_table :demand_package_disclosure_segments
  end
end
