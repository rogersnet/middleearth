class PurchaseCostItems < ActiveRecord::Base

  belongs_to :purchase_cost_header

  validates_presence_of :purchase_cost_header_id
  validates_presence_of :category
  validates_presence_of :cost

  validates_uniqueness_of :category, :scope => :purchase_cost_header_id
end
