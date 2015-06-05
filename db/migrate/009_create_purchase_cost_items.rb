class CreatePurchaseCostItems < ActiveRecord::Migration
  def self.up
    create_table :purchase_cost_items do |t|
      t.integer :purchase_cost_header_id
      t.string :category
      t.float :cost
      t.timestamps
    end
  end

  def self.down
    drop_table :purchase_cost_items
  end
end
