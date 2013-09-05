require 'rubygems' unless defined?(Gem)
require 'mail'
require 'logger'
require 'sequel'
require 'sqlite3'
require 'yaml'

# Delete lock file for webcam if it exists
webcam_lock_file = '/tmp/hornetseye-ruby2.0.0-pi/lock'
`rm #{webcam_lock_file}` if File.exists?(webcam_lock_file)

require_relative '../lib/growcontrol'

# Configuration
$config = YAML.load_file('./config/config.yml')

# SQLite database accessor
DB = Sequel.sqlite("./db/GrowControl.db")

# Write environment variable to config
$config[:environment] = ENV['RACK_ENV'] || "development"

# Logger for growcontrol daemon
LOGGER = Logger.new(STDOUT)
LOGGER.level = Logger::INFO

WEB_LOGGER = Logger.new("./log/growcontrol_web_#{$config[:environment]}.log")
WEB_LOGGER.datetime_format = "%Y/%m/%d @ %H:%M:%S "
WEB_LOGGER.level = Logger::INFO if $config[:environment] == "production"
