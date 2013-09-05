require 'tellstickr'

module GrowControl

  class Feeder

    attr_reader :device

    def initialize
      @device = TellStickR::Device.new(*$config[:feeding_device])
    end

    def start
      @device.on
    end

    def stop
      @device.off
    end

  end

end
