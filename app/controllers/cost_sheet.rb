Middleearth.controllers :cost_sheet do
  # Sample Request
  # {
  #   gameboard_id: 1,
  #   investment_packages: [
  #      {header: 'marketing_cost', package: '10% increase in demand', cost: 18},
  #      {header: 'operations_cost', package: '3500 orders/week', cost: 12000}
  #   ],
  #   purchase_cost: [
  #      {stock_lower_bound: 0,
  #       stock_upper_bound: 500,
  #       items: [
  #           {segment:'entry', category:'formal', cost:1000},
  #           {segment:'entry', category:'casual', cost:200}
  #       ]}
  #   ]
  # }

  post :create do
    response = CostSheet.create_from_hash(params.with_indifferent_access)
    json_status response.status, response.message
  end

  get :show, :with => :gameboard_id do
    response = CostSheet.fetch_cost_sheet_for_gameboard(params[:gameboard_id])
    json_status 200, response
  end
end
