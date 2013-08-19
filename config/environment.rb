require 'rubygems' unless defined?(Gem)
require 'forever'
require 'mail'
require 'logger'
require 'sequel'
require 'sqlite3'
require 'gruff'

LOGGER = Logger.new(STDOUT)
LOGGER.level = Logger::INFO

VIDEO_DEVICE = '/dev/video0'
IMAGE_TEMP_FILE = './tmp/webcam.jpeg'
IMAGE_DESTINATION_FILE = './public/webcam.jpeg'

TEMP_WEEKLY_GRAPH_FILE = './public/temp_week.png'
TEMP_DAILY_GRAPH_FILE = './public/temp_daily.png'
HUM_WEEKLY_GRAPH_FILE = './public/hum_week.png'
HUM_DAILY_GRAPH_FILE = './public/hum_daily.png'

DB = Sequel.sqlite("./db/GrowControl.db")

TEMPERATURE_UPPER_LIMIT = 33
TEMPERATURE_LOWER_LIMIT = 16

HUMIDITY_UPPER_LIMIT = 60
HUMIDITY_LOWER_LIMIT = 30
