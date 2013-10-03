# mbta_departures.rb

require 'sinatra'
require 'pry'
require_relative 'departure_board.rb'


# lateness in seconds, convert to minutes
# statuses:
#   On Time, Now Boarding, All Aboard, Delayed
#   Cancelled, Info to follow, TBD, Late
#   Arriving, Arrived, Departed, Hold, End

before do
  @departures = DepartureBoard.new.to_hash
  @timestamp = @departures.first["TimeStamp"].strftime("%I:%M%p %m/%d/%Y")

  @departures.map do |hash|
    hash.delete("TimeStamp")
    hash["ScheduledTime"] = hash["ScheduledTime"].strftime("%I:%M%p")

    if hash["Lateness"] = 0
      hash["Lateness"] = nil
    elsif hash["Lateness"] > 0
      hash["Lateness"] /= 60
    end

  end
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
