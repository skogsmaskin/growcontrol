module GrowControl

  class Temperature < GrowControl::Sensor

    def initialize
      super
      @db = DB[:temperatures]
    end

    def read
      @sensor.temperature
    end

  end

end
