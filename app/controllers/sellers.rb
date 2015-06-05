Middleearth.controllers :sellers do

  get :index do
    sellers = Seller.all
    json_status 200, sellers
  end

  get :show, :with => :email do
    seller = Seller.find_by_email(:email)
    json_status 200, seller
  end

  post :create do
    response = Seller.create_from_hash(params.with_indifferent_access)
    json_status 200, response
  end

end
