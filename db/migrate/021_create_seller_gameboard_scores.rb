class CreateSellerGameboardScores < ActiveRecord::Migration
  def self.up
    create_table :seller_gameboard_scores do |t|
      t.integer :seller_id
      t.integer :gameboard
      t.float :score
      t.timestamps
    end
  end

  def self.down
    drop_table :seller_gameboard_scores
  end
end
