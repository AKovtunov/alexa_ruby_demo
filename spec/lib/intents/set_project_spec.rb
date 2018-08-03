require 'spec_helper'
describe SetProject do
  let(:request_initial){
    {
      "type" => "IntentRequest",
  		"requestId" => "amzn1.echo-api.request.0a162df5-e3ec-4764-855f-239721345142",
  		"timestamp" => "2018-08-03T23 =>00 =>26Z",
  		"locale" => "en-US",
  		"intent" => {
  			"name" => "setProject",
  			"confirmationStatus" => "NONE",
  			"slots" => {
  				"name" => {
  					"name" => "name",
  					"confirmationStatus" => "NONE"
  				},
  				"budget" => {
  					"name" => "budget",
  					"confirmationStatus" => "NONE"
  				}
  			}
  		},
  		"dialogState" => "STARTED"
		}
  }

  let(:request_step1){
    {
    "type" => "IntentRequest",
		"requestId" => "amzn1.echo-api.request.65a3ceed-9dc5-42f0-8528-3f1dfb6fe2b6",
		"timestamp" => "2018-08-03T23 =>02 =>45Z",
		"locale" => "en-US",
		"intent" => {
			"name" => "setProject",
			"confirmationStatus" => "NONE",
			"slots" => {
				"name" => {
					"name" => "name",
					"value" => "new project",
					"confirmationStatus" => "NONE"
				},
				"budget" => {
					"name" => "budget",
					"value" => "NONE",
					"confirmationStatus" => "DENIED"
				}
			}
		},
		"dialogState" => "IN_PROGRESS"
    }
  }

  let(:request_step2){
    {
      "type" => "IntentRequest",
  		"requestId" => "amzn1.echo-api.request.aa276ab6-08ad-4f2f-9ae3-322ad3942d96",
  		"timestamp" => "2018-08-03T23 =>03 =>42Z",
  		"locale" => "en-US",
  		"intent" => {
  			"name" => "setProject",
  			"confirmationStatus" => "NONE",
  			"slots" => {
  				"name" => {
  					"name" => "name",
  					"value" => "new project",
  					"confirmationStatus" => "CONFIRMED"
  				},
  				"budget" => {
  					"name" => "budget",
  					"value" => "100",
  					"confirmationStatus" => "NONE"
  				}
  			}
  		},
  		"dialogState" => "IN_PROGRESS"
    }
  }

  let(:request_final){
    {
      "type" => "IntentRequest",
  		"requestId" => "amzn1.echo-api.request.aa276ab6-08ad-4f2f-9ae3-322ad3942d96",
  		"timestamp" => "2018-08-03T23 =>03 =>42Z",
  		"locale" => "en-US",
  		"intent" => {
  			"name" => "setProject",
  			"confirmationStatus" => "NONE",
  			"slots" => {
  				"name" => {
  					"name" => "name",
  					"value" => "new project",
  					"confirmationStatus" => "CONFIRMED"
  				},
  				"budget" => {
  					"name" => "budget",
  					"value" => "100",
  					"confirmationStatus" => "CONFIRMED"
  				}
  			}
  		},
  		"dialogState" => "COMPLETED"
    }
  }

  it "Alexa initializes request by sending us intention to set project without any set variables and we should respond that we agreed to keep this dialog and need this variables (DENIED status)" do
    expect(SetProject.get_response(request: request_initial)).to eql(
    {
      "version": "1.0",
      "response": {
        "directives": [
          {
            "type": "Dialog.Delegate",
            "updatedIntent": {
              "name": "setProject",
              "confirmationStatus": "NONE",
              "slots": {
                "name" => {
                  "name": "name",
                  "value": "NONE",
                  "confirmationStatus": "DENIED"
                },
                "budget" => {
                  "name": "budget",
                  "value": "NONE",
                  "confirmationStatus": "DENIED"
                }
              }
            }
          }
        ],
        "shouldEndSession": false
      }
    }
    )
  end

  it "Alexa asks about project name and sends it to us to confirm, we are confiriming this name" do
    expect(SetProject.get_response(request: request_step1)).to eql(
    {
  		"version": "1.0",
  		"response": {
  			"directives": [
  				{
  					"type": "Dialog.Delegate",
  					"updatedIntent": {
  						"name": "setProject",
  						"confirmationStatus": "NONE",
  						"slots": {
  							"name" => {
  								"name": "name",
  								"value": "new project",
  								"confirmationStatus": "CONFIRMED"
  							},
  							"budget" => {
  								"name": "budget",
  								"value": "NONE",
  								"confirmationStatus": "DENIED"
  							}
  						}
  					}
  				}
  			],
  			"shouldEndSession": false
  		}
    }
    )
  end

  it "Alexa asks about project budget and sends it to us to confirm, we are confiriming this budget" do
    expect(SetProject.get_response(request: request_step2)).to eql(
    {
    	"version": "1.0",
  		"response": {
  			"directives": [
  				{
  					"type": "Dialog.Delegate",
  					"updatedIntent": {
  						"name": "setProject",
  						"confirmationStatus": "NONE",
  						"slots": {
  							"name" => {
  								"name": "name",
  								"value": "new project",
  								"confirmationStatus": "CONFIRMED"
  							},
  							"budget" => {
  								"name": "budget",
  								"value": "100",
  								"confirmationStatus": "CONFIRMED"
  							}
  						}
  					}
  				}
  			],
  			"shouldEndSession": false
  		}
    }
    )
  end

  it "Alexa tells that all values are confirmed and we are creating project + sending her a voice message that project is created then. " do
    expect(SetProject.get_response(request: request_final)).to eql(ResponseSetter.default_schema_for_response("Project new project created. Budget set to 100"))
  end
end
