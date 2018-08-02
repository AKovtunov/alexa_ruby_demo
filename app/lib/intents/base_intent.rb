class BaseIntent
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
    @response = "Unfortuntely, I don't know this one yet"
  end

  def date_argument
    request["intent"].fetch("slots", {}).fetch("date", {}).fetch("value", nil)
  end

  def date_range(date)
    date = DateTime.parse(date)
    date.beginning_of_day .. date.end_of_day
  end

end
