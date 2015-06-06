class SellerWeekPurchaseCostPlan < ActiveRecord::Base

  belongs_to :seller_week_investment

  validates_presence_of :segment
  validates_presence_of :category
  validates_presence_of :stock_quantity

  def self.get_stock_quantity(seller_id,gameboard_id,week,segment,category)
    joins(:seller_week_investment)
      .where(:seller_week_investments => {:seller_id => seller_id, :gameboard_id => gameboard_id, :week_number => week})
       .where(:segment => segment, :category => category)
        .pluck(:stock_quantity).first
  end
end
