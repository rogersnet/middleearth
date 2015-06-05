class SellerWeekLiquidation < ActiveRecord::Base

  validates_presence_of :seller_id
  validates_presence_of :gameboard_id
  validates_presence_of :week_number

  def self.liquidate_stock(liquidate_stock_hash)
    #check if gameboard exists
    unless Gameboard.exists?(:id => liquidate_stock_hash[:gameboard_id])
      return MeResponse.new(400,'Non-existent gameboard',nil)
    end

    #check if seller exists
    unless Seller.exists?(:id => liquidate_stock_hash[:seller_id])
      return MeResponse.new(400,'Non-existent seller',nil)
    end

    response = nil
    begin
      liquidate_stock_hash[:items].each do |item|
        swl                = SellerWeekLiquidation.new
        swl.seller_id      = liquidate_stock_hash[:seller_id]
        swl.gameboard_id   = liquidate_stock_hash[:gameboard_id]
        swl.week_number    = liquidate_stock_hash[:week_number]
        swl.stock_quantity = liquidate_stock_hash[:stock_quantity]
        swl.segment        = liquidate_stock_hash[:segment]
        swl.category       = liquidate_stock_hash[:category]
        swl.save!
      end
      response = MeResponse.new(200,'Stock Liquidation successfully completed for seller',nil)
    rescue => e
      response = MeResponse.new(400,e.message,e.backtrace)
    end
    response
  end

end
