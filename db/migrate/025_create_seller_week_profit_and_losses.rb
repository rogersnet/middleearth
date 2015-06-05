class CreateSellerWeekProfitAndLosses < ActiveRecord::Migration
  def self.up
    create_table :seller_week_profit_and_losses do |t|
      t.integer :seller_id
      t.integer :gameboard_id
      t.integer :week_number
      t.float   :cogs
      t.float   :net_cogs
      t.timestamps
    end
  end

  def self.down
    drop_table :seller_week_profit_and_losses
  end
end
