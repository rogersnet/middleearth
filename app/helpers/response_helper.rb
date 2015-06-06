Middleearth.helpers do
  def json_status(code,response)
    content_type 'application/json'
    status code
    response.to_json
  end

  def validate_http_request_body(request, symbolize_names=false)
    request.body.rewind
    data = request.body.read
    raise InvalidDataError  if data.empty?
    module_request = JSON.parse(data, :symbolize_names => symbolize_names, :symbolize_keys => symbolize_names)
    raise InvalidDataError if module_request.empty?
    return module_request
  end
end