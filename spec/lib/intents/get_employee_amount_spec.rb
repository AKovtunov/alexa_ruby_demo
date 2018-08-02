require 'spec_helper'
describe GetEmployeeAmount do
  let(:request){
    {
    "type"=>"IntentRequest",
    "requestId"=>"amzn1.echo-api.request.78fec6fc-9767-4f80-b89b-deb0960193c4",
    "timestamp"=>"2018-07-31T13:54:26Z",
    "locale"=>"en-US",
    "intent"=> {
			"name" => "getEmployeeAmount",
			"confirmationStatus" => "NONE"
			}
		}
  }

  it "should return people from today" do
    count = Account.count
    expect(GetEmployeeAmount.get_response(request: request)).to eql("Currently database of the company contains 100 accounts")
  end
end
