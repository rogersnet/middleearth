Middleearth.controllers :seller_week_liquidation do

  post :liquidate do
    response = SellerWeekLiquidation.liquidate_stock(params.with_indifferent_access)
    json_status 200, response
  end

end
