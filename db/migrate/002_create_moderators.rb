class CreateModerators < ActiveRecord::Migration
  def self.up
    create_table :moderators do |t|
      t.string :name
      t.string :email
      t.string :flipkart_id
      t.timestamps
    end
  end

  def self.down
    drop_table :moderators
  end
end
