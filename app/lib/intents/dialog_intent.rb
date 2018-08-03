class DialogIntent < BaseIntent
  private
  attr_reader :slots, :selected_schema, :slot_value_hash

  def set_response_schema
    @response_schema = @selected_schema
  end

  def work_on_dialog_steps
    case
    when dialog_is_in_progress
      @selected_schema = dialog_schema
    else
      proceed_results_and_response
      @selected_schema = default_schema
    end
  end

  def dialog_is_in_progress
    ["STARTED", "IN_PROGRESS"].include? request["dialogState"]
  end

  def dialog_schema
    build_slot_value_hash
    {
      "version": "1.0",
      "response": {
        "directives": [
          "type": "Dialog.Delegate",
          "updatedIntent": {
            "name": "setProject",
            "confirmationStatus": "NONE",
            "slots": generate_slots
          }
        ],
        "shouldEndSession": false
      }
    }
  end

  def build_slot_value_hash
    hash = {}
    slots.each do |slot|
      hash[slot] = get_slot_value(slot) == "NONE" ? nil : get_slot_value(slot)
    end
    @slot_value_hash = hash
  end

  def generate_slots
    hash = {}
    slots.each do |slot|
      hash[slot] = generate_slot_hash(slot)
    end
    hash
  end

  def generate_slot_hash(name)
    variable = slot_value_hash[name]
    {
      "name": name,
      "value": variable || "NONE",
      "confirmationStatus": variable ? "CONFIRMED" : "DENIED"
    }
  end

end
