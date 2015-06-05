class CreateDemandPackageDisclosureCategories < ActiveRecord::Migration
  def self.up
    create_table :demand_package_disclosure_categories do |t|
      t.integer :demand_package_disclosure_id
      t.string :segment
      t.string :category
      t.integer :demand_size
      t.timestamps
    end
  end

  def self.down
    drop_table :demand_package_disclosure_categories
  end
end
