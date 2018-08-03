require 'active_support/core_ext/string'
class IntentSelector < RequestHandler
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
    @response = find_intent_class.get_response(request: request)
  end

  def find_intent_class
    begin
      class_name = request["intent"]["name"].classify.constantize
    rescue
      class_name = FallbackIntent
    end
    return class_name
  end

end
