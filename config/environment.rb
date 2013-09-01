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

# Logger for webapp and binary
LOGGER = Logger.new(STDOUT)
LOGGER.level = Logger::INFO

# SQLite database accessor
DB = Sequel.sqlite("./db/GrowControl.db")
