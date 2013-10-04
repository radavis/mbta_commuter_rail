require 'csv'
require 'open-uri'

class DepartureBoard
  URL = "http://developer.mbta.com/lib/gtrtfs/Departures.csv"
  CSV_FILE = 'data/departures.csv'
  UPDATE_FREQUENCY = 30  # seconds

  attr_reader :board

  def initialize
    update
  end

  def to_hash
    @board
  end

  private
  def update
    grab_csv if (Time.now - File.mtime(CSV_FILE)).to_i > UPDATE_FREQUENCY

    @board = []
    CSV.foreach(CSV_FILE,
            headers: true,
            converters: :all,
            col_sep: ',') do |row|

      row["TimeStamp"] = Time.at(row["TimeStamp"])
      row["ScheduledTime"] = Time.at(row["ScheduledTime"])
      @board << row.to_hash
    end
    @board
  end

  def grab_csv
    remote_data = open(URL).read
    departures_csv = File.open(CSV_FILE, "w")
    departures_csv.write(remote_data)
    departures_csv.close
  end

end
