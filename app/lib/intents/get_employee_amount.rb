class GetEmployeeAmount
  attr_reader :response

  def initialize
    set_response
  end

  def self.response
    new.response
  end

  private
  def set_response
    @response = "Currently database of the company contains #{Account.count} accounts"
  end

end
