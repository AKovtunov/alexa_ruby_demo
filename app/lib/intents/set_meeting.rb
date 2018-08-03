class SetMeeting < DialogIntent

  private

  def set_response
    @slots = ["date", "reason"]
    work_on_dialog_steps
  end

  def proceed_results_and_response
    new_project = Meeting.create(date: DateTime.parse(get_slot_value("date")), reason: get_slot_value("reason"))
    @response = "Meeting on #{new_project.date.to_date} created. Reason of the meeting is #{new_project.reason}"
  end

end
