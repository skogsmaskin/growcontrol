require 'hornetseye_v4l2'
require 'hornetseye_rmagick'
require 'RMagick'

module GrowControl

  class WebCam

    include Hornetseye
    include Magick

    attr_reader :video_device, :input

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
      img = ImageList.new(temp_file)
      txt = Draw.new
      img.annotate(txt, 0,0,0,0, Time.now.to_s) do
        txt.gravity = Magick::SouthEastGravity
        self.pointsize = 30
        self.font_family = 'Arial'
        self.font_weight = BoldWeight
        self.stroke = '#000000'
        self.fill = '#ffffff'
      end
      img.write(dest_file)
      File.delete(temp_file)
    end

    def close
      @input.close
    end

  end

end
