class PurchaseCostItems < ActiveRecord::Base

  belongs_to :purchase_cost_header

  validates_presence_of :purchase_cost_header_id
  validates_presence_of :category
  validates_presence_of :cost

  validates_uniqueness_of :category, :scope => :purchase_cost_header_id

  def self.get_buying_cost(gameboard_id,segment,category, seller_decl)
    sql = "SELECT cost FROM purchase_cost_items pi INNER JOIN purchase_cost_headers ph ON ph.id = pi.purchase_cost_header_id AND ph.segment = '#{segment}'" +
          " INNER JOIN cost_sheets cs ON ph.cost_sheet_id = cs.id and cs.gameboard_id = '#{gameboard_id}' WHERE " +
          " pi.category = '#{category}' AND ph.stock_lower_bound >= #{seller_decl} AND ph.stock_upper_bound <= #{seller_decl} AND ph.stock_upper_bound IS NOT NULL"
    result = ActiveRecord::Base.connection.execute(sql)
    (result.first.nil?)?-1:result.first[0]
  end
end
