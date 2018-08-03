class StopIntent < BaseIntent
  def set_response
    @should_end_session = true
    @response = "If you will need any more help, just call my name."
  end
end
