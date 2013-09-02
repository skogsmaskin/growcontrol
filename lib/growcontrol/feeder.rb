require 'tellstickr'

module GrowControl

  class Feeder

    attr_reader :device

    def initialize
      @device = TellStickR::Device.discover.first
    end

    def start
      @device.on
    end

    def stop
      @device.off
    end

  end

end
