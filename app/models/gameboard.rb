class Gameboard < ActiveRecord::Base

  has_many :gameboard_week_maps

  def self.table
    self.arel_table
  end

  def current_status
    self.gameboard_week_maps.select(GameboardWeekMap.table[:status]).last
  end
end
