class SetMeeting < DialogIntent

  private

  def set_slots
    @slots = ["date", "reason", "time"]
  end

  def proceed_results_and_response
    date = DateTime.parse(get_slot_value("date"))
    time = get_slot_value("time")
    date_time = DateTime.parse(date.strftime("%Y-%m-%dT#{time}:00%z"))
    new_project = Meeting.create(date: date_time, reason: get_slot_value("reason"))
    @response = "Meeting on #{new_project.date.to_date} at #{get_slot_value("time")} created. Reason of the meeting is #{new_project.reason}"
  end

end
