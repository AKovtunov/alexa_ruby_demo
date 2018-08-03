class SetProject < DialogIntent
  private
  attr_reader :name, :budget

  def set_response
    @slots = ["name", "budget"]
    case
    when request["dialogState"] == "STARTED"
      @selected_schema = dialog_schema
    when request["dialogState"] == "IN_PROGRESS"
      @name = get_slot_value("name")
      @budget = get_slot_value("budget") == "NONE" ? nil : get_slot_value("budget").to_i
      @selected_schema = dialog_schema
    else
      new_project = Project.create(title: get_slot_value("name"), budget: get_slot_value("budget"))
      @response = "Project #{new_project.title} created. Budget set to #{new_project.budget}"
      @selected_schema = default_schema
    end

  end

  def set_response_schema
    @response_schema = @selected_schema
  end


end
