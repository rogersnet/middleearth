class CreateSellerWeekPurchaseCostPlanItems < ActiveRecord::Migration
  def self.up
    create_table :seller_week_purchase_cost_plan_items do |t|
      t.integer :header_id
      t.string :category
      t.float :cost
      t.timestamps
    end
  end

  def self.down
    drop_table :seller_week_purchase_cost_plan_items
  end
end
