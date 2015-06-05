class CreateCostSheetInvestmentPackages < ActiveRecord::Migration
  def self.up
    create_table :cost_sheet_investment_packages do |t|
      t.integer :cost_sheet_id
      t.string :header
      t.string :package
      t.float :cost_per_week
      t.timestamps
    end
  end

  def self.down
    drop_table :cost_sheet_investment_packages
  end
end
