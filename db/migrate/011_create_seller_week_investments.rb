class CreateSellerWeekInvestments < ActiveRecord::Migration
  def self.up
    create_table :seller_week_investments do |t|
      t.integer :seller_id
      t.integer :gameboard_id
      t.integer :week_number
      t.integer :operating_cost_id
      t.integer :marketing_cost_id
      t.integer :inventory_cost_id
      t.float :loan
      t.timestamps
    end
  end

  def self.down
    drop_table :seller_week_investments
  end
end
