# encoding: utf-8
$:.unshift(File.dirname(__FILE__))

require 'config/environment'
require 'app/growcontrol'

map '/' do
  run GrowControlApp
end
