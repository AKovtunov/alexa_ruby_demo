require 'sinatra'
require 'sinatra/activerecord'
require 'pry'

require_relative "app/lib/required_files.rb"

set :views, Proc.new { File.join(root, "app/views") }

post '/' do
  hash = JSON.parse(request.body.read)
  p "===================================================== REQUEST ================================================"
  p hash
  p "=============================================================================================================="
  response = RequestHandler.get_response(request: hash["request"]).to_json
  p "===================================================== RESPONSE ================================================"
  p response
  p "=============================================================================================================="
  response


end

get '/ui' do
  @presenter = ViewPresenter.fetch_data
  haml :index
end
