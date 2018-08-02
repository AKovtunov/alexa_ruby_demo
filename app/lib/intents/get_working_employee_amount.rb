class GetWorkingEmployeeAmount < BaseIntent
  private
  def set_response
    if date_argument
      amount = Account.where(last_checked_date: date_range(date_argument)).count
    else
      amount = Account.where(last_checked_date: date_range(DateTime.now.to_s)).count
    end
    date = date_argument ? date_argument : "current date"
    @response = "On #{date} we have #{amount} of people checked in the system"
  end

end
