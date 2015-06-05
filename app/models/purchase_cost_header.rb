class PurchaseCostHeader < ActiveRecord::Base

  #Each header belongs to single cost sheet
  belongs_to :cost_sheet

  #Each header has many purchase cost items
  has_many :purchase_cost_items

  validates_presence_of :cost_sheet_id
  validates_presence_of :segment
end
