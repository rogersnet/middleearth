class GameboardSellerMap < ActiveRecord::Base

  def self.by_gameboard(gameboard_id)
    where(:gameboard_id => gameboard_id).select(:seller_id)
  end

  def self.register_with_gameboard(params)
    unless Seller.exists?(:id => params[:seller_id])
      return MeResponse.new(400,'Invalid Seller Id',nil)
    end

    unless Gameboard.exists?(:id => params[:gameboard_id])
      return MeResponse.new(400,'Invalid gameboard Id',nil)
    end

    response = nil
    begin
      ActiveRecord::Base.transaction do
        gameboard_seller_map = GameboardSellerMap.new
        gameboard_seller_map.seller_id = params[:seller_id]
        gameboard_seller_map.gameboard_id = params[:gameboard_id]
        gameboard_seller_map.save!
      end
      response = MeResponse.new(200,'Seller Registration successfully completed',nil)
    rescue => e
      response = MeResponse.new(400,e.message,e.backtrace)
    end
    response
  end
end
