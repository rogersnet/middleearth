class CostSheetInvestmentPackage < ActiveRecord::Base

  belongs_to :cost_sheet

  validates_presence_of :header
  validates_presence_of :package

  validates_uniqueness_of :package, :scope => :header

  def self.fetch_package_id(gameboard_id,header,package)
    joins(:cost_sheet)
      .where(:cost_sheets => {:gameboard_id => gameboard_id})
      .where(:header => header, :package => package).pluck(:id).first
  end
end
