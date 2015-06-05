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

end
