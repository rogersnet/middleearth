class AddTitleToGameboard < ActiveRecord::Migration
  def self.up
    add_column :gameboards, :title, :string
  end

  def self.down
    remove_column :gameboards,:title
  end
end
