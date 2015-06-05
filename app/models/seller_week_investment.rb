class SellerWeekInvestment < ActiveRecord::Base

  validates_presence_of :seller_id
  validates_presence_of :gameboard_id
  validates_presence_of :operating_cost_id
  validates_presence_of :marketing_cost_id
  validates_presence_of :inventory_cost_id
  validates_presence_of :week_number

  validates_uniqueness_of :week_number, :scope => [:gameboard_id,:seller_id]
end
