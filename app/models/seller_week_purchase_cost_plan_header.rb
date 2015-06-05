class SellerWeekPurchaseCostPlanHeader < ActiveRecord::Base

  has_many :seller_week_purchase_cost_plan_items, :class_name => 'SellerWeekPurchaseCostPlanItems', :foreign_key => 'header_id'

  validates_presence_of :segment

end
