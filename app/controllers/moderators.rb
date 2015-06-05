Middleearth.controllers :moderators do

  get :index do
    moderators = Moderator.all
    json_status 200, moderators
  end

  get :show, :with => :id do
    moderator = Moderator.find(params[:id])
    json_status 200, moderator
  end

end
