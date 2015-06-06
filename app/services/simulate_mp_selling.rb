class SimulateMpSelling
  def self.run_simulation(week,gameboard_id)
     #initialize seller week logs with quantity
     sellers = GameboardSellerMap.by_gameboard(gameboard_id).map(&:seller_id)

     sellers.each do |seller|
       prev_week = week.to_i - 1
       if prev_week > 0
          prev_week_logs = SellerWeekLog.where(:seller_id => seller,:gameboard_id => gameboard_id, :week_number => prev_week)
          prev_week_logs.each do |pwl|
            current_week_log = SellerWeekLog.new
            current_week_log.seller_id    = seller
            current_week_log.gameboard_id = gameboard_id
            current_week_log.week_number  = week
            current_week_log.segment      = pwl.segment
            current_week_log.category     = pwl.category
            current_week_log.quantity     = pwl.quantity + SellerWeekInvestment.get_quantity_for_segment_category(seller,gameboard_id,week,pwl.segment,pwl.category)
            current_week_log.save!
          end
       end
     end

     #now our sellers are initialized, lets simulate the selling
     #get actual demand disclosures
     actual_demand = DemandPackageDisclosure.fetch_actual_demand(week,gameboard_id)

     actual_demand.each do |demand|

       prioritized_sellers = SellerSelection.select_supplier(week,gameboard_id,demand[:segment],demand[:category])
       distributed_size    = self.distribute_quantity(demand[:demand_size],prioritized_sellers.count)

       prioritized_sellers.each_with_index do |seller,index|
          #update quantity sold for this segment
          swl = SellerWeekLog.where(:seller_id    => seller.seller_id,
                                    :week_number  => week,
                                    :gameboard_id => gameboard_id,
                                    :segment      => demand[:segment],
                                    :category     => demand[:category]).first_or_create

          quan_to_update = distributed_size[index] rescue next

          next if quan_to_update < 0

          swl.update_attributes(:quantity => quan_to_update)

          #update p & l for the seller
          pal = SellerWeekProfitAndLoss.where(:seller_id => seller.seller_id,:week_number => week, :gameboard_id => gameboard_id).first
          if pal.nil?
            pal              = SellerWeekProfitAndLoss.new
            pal.seller_id    = seller.seller_id
            pal.week_number  = week
            pal.gameboard_id = gameboard_id
            pal.save!
            pal = pal.reload
          end

          #calculate total cost of goods sold

          seller_price = SellerWeekUnitPriceDeclaration.get_unit_price_cost(seller.seller_id,gameboard_id,week,demand[:segment],demand[:category])
          begin
            cogs = distributed_size[index].to_i * seller_price + pal.cogs
          rescue => e
            p e.message
          end

          #calculate net cost
          seller_decl = SellerWeekPurchaseCostPlan.get_stock_quantity(seller.seller_id,gameboard_id,week,demand[:segment],demand[:category]) || 0
          cost_add = SellerWeekInvestment.calculate_cost_to_subtract(week,gameboard_id,seller,seller_price,distributed_size[index])
          buying_price = PurchaseCostItem.get_buying_cost(gameboard_id,demand[:segment],demand[:category],seller_decl)
          coby = buying_price.to_i * distributed_size[index]
          pal.update_attributes(:cogs => cogs, :net_cogs => coby)
       end
     end

     #update current balance
=begin
     sellers.each do |seller|
       pal = SellerWeekProfitAndLoss.where(:seller_id => seller, :gameboard_id => gameboard_id, :week_number => week)
       spc = SellerProgressCard.where(:seller_id => seller, :gameboard_id => gameboard_id).first_or_create
       bal = spc.current_balance
       spc.update_attributes(:current_balance => (bal - pal.net_cogs).abs) rescue
     end
=end

     #simulation over
     SellerWeekProfitAndLoss.where(:gameboard_id => gameboard_id, :week_number => week)
  end

  def self.distribute_quantity(quantity,size)
    result = []

    if size == 1
      result << quantity.to_i
      return result
    end

    rem_quantity = quantity.to_i
    p quantity
    while rem_quantity > 1 do
      result << (0.8 * rem_quantity).to_i
      rem_quantity = rem_quantity - (0.8 * rem_quantity).to_i
    end
    result << rem_quantity
    result
  end
end