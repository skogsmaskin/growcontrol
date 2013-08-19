require 'hornetseye_v4l2'
require 'hornetseye_rmagick'

module GrowControl

  class WebCam

    include Hornetseye

    attr_reader :video_device

    def initialize(video_device)
      @video_device = video_device
      @input = V4L2Input.new @video_device
    end

    def save(temporary_file_name, destination_file_name)
      image = @input.read
      image = @input.read_usintrgb
      image.save_ubytergb(temporary_file_name)
      `mv #{temporary_file_name} #{destination_file_name}`
    end

    def close
      @input.close
    end

  end

end
