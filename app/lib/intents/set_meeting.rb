class SetMeeting < DialogIntent
  private
  def set_response
    new_project = Meeting.create(date: DateTime.parse(get_slot_value("date")))
    @response = "Meeting on #{new_project.date.to_date} created"
  end

end
