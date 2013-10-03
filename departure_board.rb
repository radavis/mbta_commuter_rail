require 'csv'
require 'pry'
require 'open-uri'

class DepartureBoard
  URL = "http://developer.mbta.com/lib/gtrtfs/Departures.csv"

  def initialize
    update
  end

  def update
    remote_data = open(URL).read
    departures_csv = File.open("departures.csv", "w")
    departures_csv.write(remote_data)
    departures_csv.close

    @board = []
    CSV.foreach(departures_csv,
            headers: true,
            #header_converters: :downcase,
            converters: :all,
            col_sep: ',') do |row|
      #binding.pry
      row["TimeStamp"] = Time.at(row["TimeStamp"])
      row["ScheduledTime"] = Time.at(row["ScheduledTime"])
      @board << row.to_hash
    end
  end

  def to_html
    result = "<table><tr>"
    @board.first.keys.each do |key|
      result += "<th>#{key}</th>"
    end
    result += "</tr>"
    @board.each do |row|
      result += "<tr>"

      row.values.each do |item|
        item = item.strftime("%H:%M%p") if item.is_a?(Time)
        result += "<td>#{item}</td>"
      end

      result += "</tr>"
    end
    result += "<table>"
  end

end

db = DepartureBoard.new
PP.pp(db)

binding.pry
