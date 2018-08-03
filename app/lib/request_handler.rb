class RequestHandler
  attr_reader :response
  def initialize(request:)
    @request = request
    set_response
  end

  def self.get_response(request:)
    new(request: request).response
  end

  private
  attr_reader :request

  def set_response
    case request["type"]
    when "LaunchRequest"
      @response = make_default_response_schema("Welcome to your company assistant! How can I help you?")
    when "IntentRequest"
      @response = IntentSelector.get_response(request: request)
    end
  end

  def make_default_response_schema(text)
    {
      "version": "1.0",
      "response": {
        "outputSpeech": {
          "type": "PlainText",
          "text": text,
        },
        "shouldEndSession": false
      }
    }
  end

end
