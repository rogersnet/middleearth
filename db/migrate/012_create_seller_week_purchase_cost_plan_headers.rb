class CreateSellerWeekPurchaseCostPlanHeaders < ActiveRecord::Migration
  def self.up
    create_table :seller_week_purchase_cost_plan_headers do |t|
      t.integer :seller_id
      t.integer :gameboard_id
      t.integer :week_number
      t.integer :stock_lower_bound
      t.integer :stock_upper_bound
      t.string :segment
      t.timestamps
    end
  end

  def self.down
    drop_table :seller_week_purchase_cost_plan_headers
  end
end
