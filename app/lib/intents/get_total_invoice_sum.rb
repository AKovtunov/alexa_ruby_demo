class GetTotalInvoiceSum < BaseIntent
  private
  def set_response
    sum = Invoice.sum(:price)
    @response = "Invoice sum of all our invoices is #{sum}"
  end

end
