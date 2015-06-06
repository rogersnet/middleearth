Middleearth.controllers :sellers do

  get :index do
    sellers = Seller.all
    json_status 200, sellers
  end

  get :show, :with => :email do
    seller = Seller.find_by_email(params[:email])
    json_status 200, seller
  end

  post :create do
    params = validate_http_request_body request
    response = Seller.create_from_hash(params.with_indifferent_access)
    json_status 200, response
  end

  post :register do
    params = validate_http_request_body request
    response = GameboardSellerMap.register_with_gameboard(params.with_indifferent_access)
    json_status 200, response
  end

  post :update_balance do
    params = validate_http_request_body request
    response = SellerProgressCard.update_balance(params.with_indifferent_access)
    json_status response.status, response.message
  end

end
