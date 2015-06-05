Middleearth.controllers :simulation do

  #Trigger simulation
  get '/trigger' do
    week      = params[:week]
    gameboard = params[:gameboard_id]

    response = SimulateMpSelling.run_simulation(week,gameboard)
    json_status 200, response
  end
  
end
