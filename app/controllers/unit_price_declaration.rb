Middleearth.controllers :unit_price_declaration do
  post :create do
    response = SellerWeekUnitPriceDeclaration.create_from_hash(params.with_indifferent_access)
    json_status 200, response
  end
end
