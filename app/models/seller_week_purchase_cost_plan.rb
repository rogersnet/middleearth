class SellerWeekPurchaseCostPlan < ActiveRecord::Base

  belongs_to :seller_week_investment

  validates_presence_of :segment
  validates_presence_of :category
  validates_presence_of :stock_quantity

end
