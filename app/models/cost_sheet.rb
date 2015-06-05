class CostSheet < ActiveRecord::Base

  #Each cost sheet belongs to a single game board
  belongs_to :gameboard

  #Each cost sheet can have many investment packages, purchase cost split across stock quantities and categories
  has_many :cost_sheet_investment_packages
  has_many :purchase_cost_headers
  has_many :purchase_cost_items, :through => :purchase_cost_headers

  validates_uniqueness_of :gameboard_id

  # Sample Request
  # {
  #   gameboard_id => 1,
  #   investment_packages=> [
  #      {header => 'marketing_cost', package => '10% increase in demand', cost => 18000},
  #      {header => 'operations_cost', package => '3500 orders/week', cost => 12000}
  #   ],
  #   purchase_cost => [
  #      {stock_lower_bound => 0,
  #       stock_upper_bound => 500,
  #       segment => 'entry'
  #       items=> [
  #           {category=>'formal', cost=>1000},
  #           {category=>'casual', cost=>200}
  #       ]}
  #   ]
  # }
  def self.create_from_hash(cost_sheet_hash)
    #check if gameboard exists
    unless Gameboard.exists?(:id => cost_sheet_hash[:gameboard_id])
      return MeResponse.new(400,'Non-existent gameboard',nil)
    end

    response = nil
    #gameboard exists, let's continue from here
    begin
      ActiveRecord::Base.transaction do
        #first create the cost sheet
        cost_sheet = CostSheet.new
        cost_sheet.gameboard_id = cost_sheet_hash[:gameboard_id]
        cost_sheet.save!
        cost_sheet = cost_sheet.reload

        #now create the investment packages
        cost_sheet_hash[:investment_packages].each do |package|
          inv_package = CostSheetInvestmentPackage.new
          inv_package.cost_sheet_id = cost_sheet.id
          inv_package.header        = package[:header]
          inv_package.package       = package[:package]
          inv_package.cost_per_week = package[:cost]
          inv_package.save!
        end

        #now create the purchase cost matrix
        cost_sheet_hash[:purchase_cost].each do |pc|
          pc_header = PurchaseCostHeader.new
          pc_header.cost_sheet_id = cost_sheet.id
          pc_header.stock_lower_bound = pc[:stock_lower_bound]
          pc_header.stock_upper_bound = pc[:stock_upper_bound]
          pc_header.segment = pc[:segment]
          pc_header.save!
          pc_header = pc_header.reload

          pc[:items].each do |item|
            pc_item = PurchaseCostItem.new
            pc_item.purchase_header_id = pc_header.id
            pc_item.category = item[:category]
            pc_item.cost     = item[:cost]
            pc_item.save!
          end
        end
      end
      response = MeResponse.new(200,'Cost Sheet successfully created',nil)
    rescue => e
      response = MeResponse.new(400,e.message,e.backtrace)
    end
    response
  end

  def self.fetch_cost_sheet_for_gameboard(gameboard_id)
    #return nil if no gameboard exists
    return nil unless Gameboard.exists?(:id => gameboard_id)

    response = {}
    cost_sheet = CostSheet.find_by_gameboard_id(gameboard_id)
    response.gameboard_id = gameboard_id

    #fill in the investment pacakges
    response.investment_packages = []
    cost_sheet.cost_sheet_investment_packages.each do |package|
      response.investment_packages << {:header => package.header, :package => package.package, :cost_per_week => package.cost_per_week }
    end

    #fill in the purchase cost matrix
    response.purchase_cost = []
    cost_sheet.purchase_cost_headers.each do |pch|
      pc = {}
      pc.stock_lower_bound = pch.stock_lower_bound
      pc.stock_upper_bound = pch.stock_upper_bound
      pc.segment           = pch.segment
      pc.items             = []
      pch.items.each do |items|
        pc.items << {:category => items.category, :cost => items.cost}
      end

      response.purchase_cost << pc
    end
    response
  end
end
