class CreateSellerWeekLogs < ActiveRecord::Migration
  def self.up
    create_table :seller_week_logs do |t|
      t.integer :seller_id
      t.integer :gameboard_id
      t.integer :week_number
      t.integer :quantity
      t.string :segment
      t.string :category
      t.timestamps
    end
  end

  def self.down
    drop_table :seller_week_logs
  end
end
