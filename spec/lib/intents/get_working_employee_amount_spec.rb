require 'spec_helper'
describe GetWorkingEmployeeAmount do

  before do
    10.times do |t|
      Account.create(
        full_name: "Worker #{t}",
        last_checked_date: Time.now.utc,
        project_id: 1,
        role: ["manager", "developer", "designer", "admin", "director"][Random.rand(0..4)],
        created_at: DateTime.now,
        updated_at: DateTime.now
      )
    end
    5.times do |t|
      Account.create(
        full_name: "Worker #{t}",
        last_checked_date: Time.now.utc.next_day,
        project_id: 1,
        role: ["manager", "developer", "designer", "admin", "director"][Random.rand(0..4)],
        created_at: DateTime.now,
        updated_at: DateTime.now
      )
    end
  end

  it "should return people from today" do
    request =
      {
        "intent"=> {
    			"name" => "getWorkingEmployeeAmount",
    			"confirmationStatus" => "NONE",
    			"slots" => {
    				"date" => {
    					"name" => "date",
    					"value" =>Time.now.utc.to_s,
    					"confirmationStatus" => "NONE"
  				  }
  			  }
  		  }
      }
    expect(GetWorkingEmployeeAmount.get_response(request: request)).to eql(ResponseSetter.default_schema_for_response("On #{Time.now.utc.to_s} we have 10 of people checked in the system"))
  end

  it "should return people from any date" do
    request =
      {
        "type"=>"IntentRequest",
        "requestId"=>"amzn1.echo-api.request.78fec6fc-9767-4f80-b89b-deb0960193c4",
        "timestamp"=>"2018-07-31T13:54:26Z",
        "locale"=>"en-US",
        "intent"=> {
          "name" => "getWorkingEmployeeAmount",
          "confirmationStatus" => "NONE",
          "slots" => {
            "date" => {
              "name" => "date",
              "value" => Time.now.utc.next_day.to_s,
              "confirmationStatus" => "NONE"
            }
          }
        }
      }
    expect(GetWorkingEmployeeAmount.get_response(request: request)).to eql(ResponseSetter.default_schema_for_response("On #{Time.now.utc.next_day} we have 5 of people checked in the system"))
  end

  it "should return no people from old dates" do
    request =
      {
        "type"=>"IntentRequest",
        "requestId"=>"amzn1.echo-api.request.78fec6fc-9767-4f80-b89b-deb0960193c4",
        "timestamp"=>"2018-07-31T13:54:26Z",
        "locale"=>"en-US",
        "intent"=> {
          "name" => "getWorkingEmployeeAmount",
          "confirmationStatus" => "NONE",
          "slots" => {
            "date" => {
              "name" => "date",
              "value" => Date.parse("15/05/1995").to_s,
              "confirmationStatus" => "NONE"
            }
          }
        }
      }
    expect(GetWorkingEmployeeAmount.get_response(request: request)).to eql(ResponseSetter.default_schema_for_response("On #{Date.parse("15/05/1995")} we have 0 of people checked in the system"))
  end
end
