class SellerWeekUnitPriceDeclaration < ActiveRecord::Base

  validates_presence_of :seller_id, :gameboard_id, :week_number, :segment, :category, :cost

  def self.create_from_hash(unit_price_hash)
    #check if gameboard exists
    unless Gameboard.exists?(:id => unit_price_hash[:gameboard_id])
      return MeResponse.new(400,'Non-existent gameboard',nil)
    end

    #check if seller exists
    unless Seller.exists?(:id => unit_price_hash[:seller_id])
      return MeResponse.new(400,'Non-existent seller',nil)
    end

    response = nil
    begin
      unit_price_hash[:unit_price_items].each do |item|
        unit_price_decl = SellerWeekUnitPriceDeclaration.new
        unit_price_decl.seller_id = unit_price_hash[:seller_id]
        unit_price_decl.gameboard_id = unit_price_hash[:gameboard_id]
        unit_price_decl.week_number = unit_price_hash[:week_number]
        unit_price_decl.segment = item[:segment]
        unit_price_decl.category = item[:category]
        unit_price_decl.cost = item[:cost]
        unit_price_decl.save!
        response = MeResponse.new(200,'Unit Price successfully created',nil)
      end
    rescue => e
      respone = MeResponse.new(400,e.message,e.backtrace)
    end
    response
  end

  def self.get_unit_price_cost(seller_id,gameboard_id,week_number,segment,category)
    where(:seller_id => seller_id,
          :gameboard_id => gameboard_id,
          :week_number => week_number,
          :segment => segment,
          :category => category).pluck(:cost).first
  end
end
