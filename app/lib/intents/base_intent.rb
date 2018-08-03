class BaseIntent
  attr_reader :response, :should_end_session

  def initialize(request:)
    @request = request
    @should_end_session = false
    set_response
    @response = apply_response_schema(response)
    after_callback
  end

  def self.get_response(request:)
    new(request: request).response
  end

  private
  attr_reader :request

  def after_callback

  end

  def set_response
    @response = "Unfortuntely, I don't know this one yet. Try to say get help to get additional help."
  end

  def get_slot_value(name)
    request["intent"].fetch("slots", {}).fetch(name, {}).fetch("value", nil)
  end

  def date_argument
    get_slot_value("date")
  end

  def date_range(date)
    date = DateTime.parse(date)
    date.beginning_of_day .. date.end_of_day
  end

  def apply_response_schema(response)
    {
      "version": "1.0",
      "response": {
        "outputSpeech": {
          "type": "PlainText",
          "text": response,
        },
        "shouldEndSession": @should_end_session
      }
    }
  end

end
