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
          "value" => Date.today.to_s,
          "confirmationStatus" => "NONE"
        }
      }
    }
  }
