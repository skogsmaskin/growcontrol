require 'hornetseye_v4l2'
require 'hornetseye_rmagick'
include Hornetseye
input = V4L2Input.new '/dev/video0'
input.read_usintrgb.save_ubytergb('./tmp/test.jpg')



## Requirements
```
sudo apt-get install sqlite3
sudo apt-get install sendmail
sudo apt-get install linux-libc-dev libswscale-dev libboost-dev libxv-dev
sudo apt-get install imagemagick ghostscript libmagickwand-dev
```
