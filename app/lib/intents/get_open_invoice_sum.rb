class GetOpenInvoiceSum < BaseIntent
  private
  def set_response
    if date_argument
      invoices = Invoice.where(created_at: date_range(date_argument))
    else
      invoices = Invoice.where(created_at: date_range(DateTime.now.to_s))
    end
    date = date_argument ? date_argument : "current date"
    sum = invoices.where.not(closed: true).sum(:price)
    @response = "Invoice sum of all our open invoices on #{date} is #{sum}"
  end

end
