Middleearth.helpers do
  def json_status(code,response)
    content_type 'application/json'
    status code
    response.to_json
  end
end