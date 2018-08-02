require 'date'
require_relative "request_handler.rb"
require_relative "intent_selector.rb"
Dir["#{__dir__}/../lib/intents/*.rb"].sort.each { |f| load(f) }
Dir["#{__dir__}/../models/*.rb"].sort.each { |f| load(f) }
