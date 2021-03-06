class CreateSellerWeekPurchaseCostPlan < ActiveRecord::Migration
  def self.up
    create_table :seller_week_purchase_cost_plans do |t|
      t.integer :seller_week_investment_id
      t.integer :stock_quantity
      t.string  :segment
      t.string  :category
      t.timestamps
    end
  end

  def self.down
    drop_table :seller_week_purchase_cost_plans
  end
end
