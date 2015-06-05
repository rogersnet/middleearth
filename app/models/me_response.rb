class MeResponse
  attr_accessor :status, :message, :trace

  def initialize(status, message, trace)
    @status = status
    @message = message
    @trace = trace
  end
end