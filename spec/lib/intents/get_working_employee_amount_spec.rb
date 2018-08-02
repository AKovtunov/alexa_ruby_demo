require 'spec_helper'
describe GetWorkingEmployeeAmount do

  it "should return people from today" do
    request =
      {
        "intent"=> {
    			"name" => "getWorkingEmployeeAmount",
    			"confirmationStatus" => "NONE",
    			"slots" => {
    				"date" => {
    					"name" => "date",
    					"value" => Date.today.to_s,
    					"confirmationStatus" => "NONE"
  				  }
  			  }
  		  }
      }
    count = Account.where(last_checked_date: DateTime.now.beginning_of_day..DateTime.now.end_of_day).count
    expect(GetWorkingEmployeeAmount.get_response(request: request)).to eql("On #{Date.today.to_s} we have #{count} of people checked in the system")
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
              "value" => Date.today.next_day.to_s,
              "confirmationStatus" => "NONE"
            }
          }
        }
      }
    count = Account.where(last_checked_date: DateTime.now.beginning_of_day.next_day .. DateTime.now.end_of_day.next_day).count
    expect(GetWorkingEmployeeAmount.get_response(request: request)).to eql("On #{Date.today.next_day} we have #{count} of people checked in the system")
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
    count = Account.where(last_checked_date: DateTime.parse("15/05/1995").beginning_of_day .. DateTime.parse("15/05/1995").end_of_day).count
    expect(GetWorkingEmployeeAmount.get_response(request: request)).to eql("On #{Date.parse("15/05/1995")} we have #{count} of people checked in the system")
  end
end
