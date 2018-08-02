require 'sinatra'
require 'sinatra/activerecord'
require 'pry'

require_relative "app/lib/required_files.rb"

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
