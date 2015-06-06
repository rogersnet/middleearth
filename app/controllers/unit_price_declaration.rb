Middleearth.controllers :unit_price_declaration do
  post :create do
    params = validate_http_request_body request
    response = SellerWeekUnitPriceDeclaration.create_from_hash(params.with_indifferent_access)
    json_status 200, response
  end
end
