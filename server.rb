require 'sinatra'
require 'sinatra/activerecord'
require 'pry'
require "#{__dir__}/app/lib/request_handler"
# Dir[File.join(__dir__, 'app', '*', '*', '*.rb')].each { |file| require file }
Dir["#{__dir__}/app/**/*.rb"].each { |f| load(f) }
post '/' do
  hash = JSON.parse(request.body.read)
  p hash
  response = RequestHandler.get_response(request: hash["request"])
  {
    "version": "1.0",
    "response": {
      "outputSpeech": {
        "type": "PlainText",
        "text": response,
      },
      "shouldEndSession": false
    }
  }.to_json

end
# "text": "Currently our company has #{acc_count} workers. Do you want to know something else?",
