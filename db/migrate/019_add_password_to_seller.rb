class AddPasswordToSeller < ActiveRecord::Migration
  def self.up
    add_column :sellers, :password, :string
  end

  def self.down
    remove_column :sellers, :password
  end
end
