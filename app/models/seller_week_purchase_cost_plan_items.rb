class SellerWeekPurchaseCostPlanItems < ActiveRecord::Base

  belongs_to :seller_week_purchase_cost_plan_header, :class_name => 'SellerWeekPurchaseCostPlanItems', :foreign_key => 'header_id'

  validates_presence_of :category
  validates_presence_of :cost
end
