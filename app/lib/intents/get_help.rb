class GetHelp < BaseIntent
  private
  def set_response
    @response = %Q( I'm your office assistant.
      You can ask me different questions like:
      How many employees do we have?
      Or how many employees are working on date?
      Also, you can set a meeting by saying Set meeting on date. )
  end

end
