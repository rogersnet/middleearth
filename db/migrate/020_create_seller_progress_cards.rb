class CreateSellerProgressCards < ActiveRecord::Migration
  def self.up
    create_table :seller_progress_cards do |t|
      t.integer :seller_id
      t.integer :gameboard_id
      t.integer :week_number
      t.integer :quantity_procured
      t.float   :procurement_cost
      t.integer :balance_stock
      t.float   :closing_balance
      t.integer :current_balance
      t.timestamps
    end
  end

  def self.down
    drop_table :seller_progress_cards
  end
end
