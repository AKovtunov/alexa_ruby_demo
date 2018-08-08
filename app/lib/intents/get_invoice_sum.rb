class GetInvoiceSum < DialogIntent

  private

  def set_slots
    @slots = ["type", "date"]
  end

  def proceed_results_and_response
    if date_argument
      invoices = Invoice.where(created_at: date_range(date_argument))
    else
      invoices = Invoice.where(created_at: date_range(DateTime.now.to_s))
    end
    sum = with_selected_state(invoices).sum(:price)
    @response = "Invoice sum of all our #{get_slot_value("type")} invoices on #{date_argument} is #{sum}"
  end

  def date_range(date)
    date = DateTime.parse("#{date}-01")
    date.beginning_of_day .. date.next_month.prev_day.end_of_day
  end

  def with_selected_state(invoices)
    return case get_slot_value("type")
    when "closed", "close"
      invoices.where(closed: true)
    when "opened", "open"
      invoices.where(closed: false)
    else
      invoices
    end
  end


end
