class GetIncome < BaseIntent
  private
  def set_response
    project_sum = Project.sum(:budget)
    invoice_sum = Invoice.sum(:price)
    @response = "Our income this year is #{project_sum - invoice_sum}."
  end

end
