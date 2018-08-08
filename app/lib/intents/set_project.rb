class SetProject < DialogIntent
  private

  def set_slots
    @slots = ["name", "budget"]
  end

  def proceed_results_and_response
    new_project = Project.create(title: get_slot_value("name"), budget: get_slot_value("budget"))
    @response = "Project #{new_project.title} created. Budget set to #{new_project.budget}"
  end

end
