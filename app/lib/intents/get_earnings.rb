class GetEarnings < BaseIntent
  private
  def set_response
    project_sum = Project.sum(:budget)
    invoice_sum = Invoice.sum(:price)
    @response = "This year, difference between your income and spends is #{project_sum - invoice_sum} EUR."
  end

end
