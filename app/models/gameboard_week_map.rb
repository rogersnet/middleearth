class GameboardWeekMap < ActiveRecord::Base

  belongs_to :gameboard

  def self.table
    self.arel_table
  end
end
