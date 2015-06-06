Middleearth.controllers :seller_week_liquidation do

  post :liquidate do
    params = validate_http_request_body request
    response = SellerWeekLiquidation.liquidate_stock(params.with_indifferent_access)
    json_status 200, response
  end

end
