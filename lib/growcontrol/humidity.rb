module GrowControl

  class Humidity < GrowControl::Sensor

    def initialize
      super
      @db = DB[:humidities]
    end

    def read
      @sensor.humidity
    end

  end

end
