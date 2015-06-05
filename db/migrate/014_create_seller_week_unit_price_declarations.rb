class CreateSellerWeekUnitPriceDeclarations < ActiveRecord::Migration
  def self.up
    create_table :seller_week_unit_price_declarations do |t|
      t.integer :seller_id
      t.integer :gameboard_id
      t.integer :week_number
      t.string :segment
      t.string :category
      t.float :cost
      t.timestamps
    end
  end

  def self.down
    drop_table :seller_week_unit_price_declarations
  end
end
