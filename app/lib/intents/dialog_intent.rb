class DialogIntent < BaseIntent
  private
  attr_reader :slots, :selected_schema, :slot_value_hash

  def dialog_schema
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

  def generate_slots
    hash = {}
    slots.each do |slot|
      hash[slot] = generate_slot_hash(slot)
    end
    hash
  end

  def generate_slot_hash(name)
    variable = instance_variable_get("@#{name}")
    {
      "name": name,
      "value": variable || "NONE",
      "confirmationStatus": variable ? "CONFIRMED" : "DENIED"
    }
  end

end
