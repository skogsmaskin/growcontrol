require 'tellstickr'

module GrowControl

  class Sensor

    attr_reader :sensor, :db

    def initialize
      @sensor = TellStickR::Sensor.from_predefined(:wt450h, 11)
    end

    def log
      data = read
      @db.insert(value: data[:value], time: data[:time])
      data
    end

    def table_name
      @db.sql.match(/\`.*?\`/).to_s.gsub('`', '')
    end

    def week
      week_ago = Time.now-(86400*7)
      DB.fetch("SELECT AVG(value) AS average, strftime('%Y%m%d%H', time) AS gt FROM #{table_name} WHERE time > '#{week_ago}' GROUP BY gt").all.map {|r|
        {
          time: Time.mktime(r[:gt][0..3], r[:gt][4..5], r[:gt][6..7], r[:gt][8..9]),
          value: r[:average].round(1)
        }
      }
    end

    def day
      day_ago = Time.now-86400
      DB.fetch("SELECT AVG(value) AS average, strftime('%Y%m%d%H', time) AS gt FROM #{table_name} WHERE time > '#{day_ago}' GROUP BY gt").all.map {|r|
        {
          time: Time.mktime(r[:gt][0..3], r[:gt][4..5], r[:gt][6..7], r[:gt][8..9]),
          value: r[:average].round(1)
        }
      }
    end

    def hour
       hour_ago = Time.now-3600
       @db.filter("time > '#{hour_ago}'").all
    end

    def write_graph(kind, file_name)
      g = Gruff::Line.new
      data_title = case table_name
        when "temperatures" then "Temperature"
        when "humidities" then "Humidity"
        else "No title"
      end
      case kind
        when :day
          g.title = "Last 24 hours"
        when :week
          g.title = "Last week"
        else
          g.title = "Unknown"
      end
      data = self.send(kind)
      g.data(data_title, data.map{|entry| entry[:value]})
      labels = {}
      i = 0
      data.each do |entry|
        labels[i] = entry[:time].strftime("%H")
        i += 1
      end
      g.labels = labels
      begin
        g.write(file_name)
      rescue Exception => e
        LOGGER.error(e)
        LOGGER.error("Data is: #{data.inspect}")
      end
    end

  end

end
