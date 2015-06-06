Middleearth.controllers :seller_week_investment do
  # Sample Request
  # {
  #   gameboard_id: 1,
  #   seller_id:1,
  #   week_number:1
  #   investment_packages: [
  #      {header: 'marketing_cost', package: '3500orders/week' }
  #   ],
  #   purchase_cost:[
  #      { stock_quantity: 500,
  #        segment: 'entry',
  #        category: 'formal'}
  #    ]
  # }
  post :create do
    params = validate_http_request_body request
    response = SellerWeekInvestment.create_from_hash(params.with_indifferent_access)
    json_status 200, response
  end

end
