class ViewPresenter
  attr_reader :user_count, :invoice_count, :project_count
  attr_reader :invoice_sum, :open_invoice_sum, :closed_invoice_sum
  attr_reader :latest_project
  attr_reader :latest_meeting

  def self.fetch_data
    new.collect_data
  end

  def collect_data
    @user_count = ::Account.count
    @invoice_count = ::Invoice.count
    @project_count = ::Project.count
    @invoice_sum = ::Invoice.sum(:price)
    @open_invoice_sum = ::Invoice.where.not(closed: true).sum(:price)
    @closed_invoice_sum = ::Invoice.where(closed: true).sum(:price)
    @latest_project = ::Project.last
    @latest_meeting = ::Meeting.last
    self
  end


end
