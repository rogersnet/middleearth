class SellerWeekInvestment < ActiveRecord::Base

  has_many :seller_week_purchase_cost_plan

  validates_presence_of :seller_id
  validates_presence_of :gameboard_id
  validates_presence_of :operating_cost_id
  validates_presence_of :marketing_cost_id
  validates_presence_of :inventory_cost_id
  validates_presence_of :week_number

  validates_uniqueness_of :week_number, :scope => [:gameboard_id,:seller_id]

  def self.create_from_hash(seller_week_inv_hash)
    #check if gameboard exists
    unless Gameboard.exists?(:id => seller_week_inv_hash[:gameboard_id])
      return MeResponse.new(400,'Non-existent gameboard',nil)
    end

    #check if seller exists
    unless Seller.exists?(:id => seller_week_inv_hash[:seller_id])
      return MeResponse.new(400,'Non-existent seller',nil)
    end

    #no error lets continue
    begin
      ActiveRecord::Base.transaction do
        week_inv = SellerWeekInvestment.new
        week_inv.seller_id    = seller_week_inv_hash[:seller_id]
        week_inv.gameboard_id = seller_week_inv_hash[:gameboard_id]
        week_inv.week_number  = seller_week_inv_hash[:week_number]

        seller_week_inv_hash.investment_packages.each do |inv|
          package_id = CostSheet.where(:gameboard_id => seller_week_inv_hash[:gameboard_id],
                                       :header       => inv[:header],
                                       :package      => inv[:package]).select(:id).first
          case inv.header
            when 'marketing_cost'
              week_inv.marketing_cost_id = package_id
            when 'operating_cost'
              week_inv.operating_cost_id = package_id
            when 'inventory_cost'
              week_inv.inventory_cost_id = package_id
          end
        end
        week_inv.save!

        week_inv = week_inv.reload

        seller_week_inv_hash.purchase_cost.each do |pc|
          header = SellerWeekPurchaseCostPlan.new
          header.seller_week_investment_plan_id = week_inv.id
          header.stock_quantity = pc[:stock_quantity]
          header.segment = pc[:segment]
          header.category = pc[:category]
          header.save!
        end
      end
      response = MeResponse.new(200,'Seller Plan successfully created',nil)
    rescue => e
      response = MeResponse.new(400,e.message,e.backtrace)
    end
    response
  end

  def self.get_quantity_for_segment_category(seller_id,gameboard_id,week_number,segment,category)
    joins(:seller_week_purchase_cost_plan)
        .where(:seller_id => seller_id, :gameboard_id => gameboard_id, :week_number => week_number)
        .where(:seller_week_purchase_cost_plan => {:segment => segment, :category=>category})
         .select(SellerWeekPurchaseCostPlan.arel_table[:stock_quantity])
  end
end
