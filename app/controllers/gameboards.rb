Middleearth.controllers :gameboards do
  get :index do
    gameboards = Gameboard.all
    json_status 200, gameboards
  end

  get :current_status, :with => :id do
    gameboard = Gameboard.find(params[:id])
    gb_status = gameboard.current_status
    json_status 200, gb_status
  end

  post :create_new_week do
    response = GameboardWeekMap.create_new_week(params.with_indifferent_access)
    json_status response.status,response.message
  end
end
