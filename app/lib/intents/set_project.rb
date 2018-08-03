class SetProject < BaseIntent
  private
  attr_reader :name, :budget, :schema

  def set_response
    puts "Name #{name}"
    puts "Budget #{budget}"
    # binding.pry
    case
    when request["dialogState"] == "STARTED"
      @schema = dialogue_model
    when request["dialogState"] == "IN_PROGRESS"
      @name = get_slot_value("name")
      @budget = get_slot_value("budget") == "NONE" ? nil : get_slot_value("budget").to_i
      @schema = dialogue_model
    else
      new_project = Project.create(title: get_slot_value("name"), budget: get_slot_value("budget"))
      @response = "Project #{new_project.title} created. Budget set to #{new_project.budget}"
      @schema = {
        "version": "1.0",
        "response": {
          "outputSpeech": {
            "type": "PlainText",
            "text": response,
          },
          "shouldEndSession": false
        }
      }
    end

  end

  def apply_response_schema(response)
    schema
  end

  def generate_slot_hash(name)
    variable = instance_variable_get("@#{name}")
    {
      "name": name,
      "value": variable || "NONE",
      "confirmationStatus": variable ? "CONFIRMED" : "DENIED"
    }
  end

  def dialogue_model
    {
      "version": "1.0",
      "response": {
        "directives": [
          "type": "Dialog.Delegate",
          "updatedIntent": {
            "name": "setProject",
            "confirmationStatus": "NONE",
            "slots": {
              "name": generate_slot_hash("name"),
              "budget": generate_slot_hash("budget")
            }
          }
        ],
        "shouldEndSession": false
      }
    }
  end
end
