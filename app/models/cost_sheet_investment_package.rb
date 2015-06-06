class CostSheetInvestmentPackage < ActiveRecord::Base

  belongs_to :cost_sheet

  validates_presence_of :header
  validates_presence_of :package

  validates_uniqueness_of :package, :scope => :header
end
