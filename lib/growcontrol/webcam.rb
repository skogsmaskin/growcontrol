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

    def save(file_path)
      Dir.mkdir(file_path) unless File.exists?(file_path)
      image = @input.read
      image = @input.read_usintrgb
      temp_file = File.join(file_path, "_webcam.jpeg")
      dest_file = File.join(file_path, "webcam.jpeg")
      image.save_ubytergb(temp_file)
      `mv #{temp_file} #{dest_file}`
    end

    def close
      @input.close
    end

  end

end
