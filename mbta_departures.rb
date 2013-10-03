# mbta_departures.rb

require 'sinatra'
require 'pry'
require_relative 'departure_board.rb'


before do
  @departures = DepartureBoard.new.to_hash
end

get '/' do
  erb :main
end

get '/north' do
  @departures.select! { |item| item["Origin"].include?("North") }
  erb :main
end

get '/south' do
  @departures.select! { |item| item["Origin"].include?("South") }
  erb :main
end
