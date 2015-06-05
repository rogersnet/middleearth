class SimulateMpSelling
  def self.run_simulation(week,gameboard_id)
     #initialize seller week logs with quantity
     sellers = GameboardSellerMap.by_gameboard(gameboard_id)

     sellers.each do |seller|
       prev_week = week - 1
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
       distributed_size    = self.distribute_quantity(demand.quantity,prioritized_sellers.count)
       prioritized_sellers.each_with_index do |seller,index|
          #update quantity sold for this segment
          swl = SellerWeekLog.where(:seller_id    => seller,
                                    :week_number  => week,
                                    :gameboard_id => gameboard_id,
                                    :segment      => demand[:segment],
                                    :category     => demand[:category]).first
          quan_to_update = swl.quantity - distributed_size[index]
          swl.update_attributes(:quantity => quan_to_update)
       end
     end

     #simulation over
  end

  def self.distribute_quantity(quantity,size)
    result = []

    rem_quantity = quantity
    while rem_quantity > 1 do
      result << (0.8 * rem_quantity).to_i
      rem_quantity = rem_quantity - (0.8 * rem_quantity).to_i
    end
    result << rem_quantity
    result
  end
end