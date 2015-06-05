Middleearth.controllers :demand_package do

  get :disclosure,:with => :id do
    response = DemandPackageDisclosure.fetch_demand_package_by_id(id)
    json_status 200, response
  end

end
