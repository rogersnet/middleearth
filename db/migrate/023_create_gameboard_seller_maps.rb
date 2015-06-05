class CreateGameboardSellerMaps < ActiveRecord::Migration
  def self.up
    create_table :gameboard_seller_maps do |t|
      t.integer :seller_id
      t.integer :gameboard_id
      t.timestamps
    end
  end

  def self.down
    drop_table :gameboard_seller_maps
  end
end
