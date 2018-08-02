class GetEmployeeAmount < BaseIntent
  private
  def set_response
    @response = "Currently database of the company contains #{Account.count} accounts"
  end

end
