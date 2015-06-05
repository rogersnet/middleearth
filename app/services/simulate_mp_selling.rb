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
     
  end
end