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

  before do
    10.times do |t|
      Account.create(
        full_name: "Worker #{t}",
        last_checked_date: DateTime.now.next_day( Random.rand(0..1) ),
        project_id: 1,
        role: ["manager", "developer", "designer", "admin", "director"][Random.rand(0..4)],

        created_at: DateTime.now,
        updated_at: DateTime.now
      )
    end
  end

  it "should return people from today" do
    count = Account.count
    expect(GetEmployeeAmount.get_response(request: request)).to eql(ResponseSetter.default_schema_for_response("Currently database of the company contains 10 accounts"))
  end
end
