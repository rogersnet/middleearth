class GameboardSellerMap < ActiveRecord::Base

  def self.by_gameboard(gameboard_id)
    where(:gameboard_id => gameboard_id).select(:seller_id)
  end
end
