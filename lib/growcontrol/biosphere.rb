module GrowControl

  class Biosphere

    attr :accessor,
      :temperature_upper_limit,
      :temperature_lower_limit,
      :humidity_upper_limit,
      :humidity_lower_limit

    attr :reader,
      :temperature_sensor,
      :humidity_sensor

    def initialize

      @temperature_upper_limit = $config[:temperature_upper_limit]
      @temperature_lower_limit = $config[:temperature_lower_limit]

      @humidity_upper_limit = $config[:humidity_upper_limit]
      @humidity_lower_limit = $config[:humidity_lower_limit]

      @temperature_sensor = Temperature.new
      @humidity_sensor = Humidity.new

    end

    def temperature
      @temperature_sensor.read
    end

    def humidity
      @humidity_sensor.read
    end

    def temperature_too_high?
      temperature[:value] > @temperature_upper_limit
    end

    def temperature_too_low?
      temperature[:value] < @temperature_lower_limit
    end

    def humidity_too_high?
      humidity[:value] > @humidity_upper_limit
    end

    def humidity_too_low?
      humidity[:value] < @humidity_lower_limit
    end

    def write_graphs!
      @temperature_sensor.write_graph(:week, $config[:image_path])
      @temperature_sensor.write_graph(:day, $config[:image_path])
      @humidity_sensor.write_graph(:week, $config[:image_path])
      @humidity_sensor.write_graph(:day, $config[:image_path])
      true
    end

    def log_values!
      res = {}
      res[:temperature] = @temperature_sensor.log
      res[:humidity] = @humidity_sensor.log
      res
    end

    def check_and_notify_status!
      @status = {:temperature => "OK", :humidity => "OK"}
      @temperature_warned_at ||= nil
      if (temperature_too_low? or temperature_too_high?) and !@temperature_warned_at
        GrowControl::Notification.warn_about_temperature(temperature[:value])
        @temperature_warned_at = Time.now
        @status[:temperature] = "Too low" if temperature_too_low?
        @status[:temperature] = "Too high" if temperature_too_high?
      end
      @humidity_warned_at ||= nil
      if (humidity_too_high? or humidity_too_low?) and !@humidity_warned_at
        GrowControl::Notification.warn_about_humidity(humidity[:value])
        @humidity_warned_at = Time.now
        @status[:humidity] = "Too low" if humidity_too_low?
        @status[:humidity] = "Too high" if humidity_too_high?
      end
      @temperature_warned_at = nil if @temperature_warned_at and (Time.now-3600) > @temperature_warned_at
      @humidity_warned_at = nil if @humidity_warned_at and (Time.now-3600) > @humidity_warned_at
      @status
    end

    def take_image!
      webcam = GrowControl::WebCam.new($config[:webcam_video_device])
      webcam.save($config[:image_path])
      webcam.close
    end

  end

end
