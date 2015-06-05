class CreatePurchaseCostHeaders < ActiveRecord::Migration
  def self.up
    create_table :purchase_cost_headers do |t|
      t.integer :cost_sheet_id
      t.integer :stock_lower_bound
      t.integer :stock_upper_bound
      t.string :segment
      t.timestamps
    end
  end

  def self.down
    drop_table :purchase_cost_headers
  end
end
