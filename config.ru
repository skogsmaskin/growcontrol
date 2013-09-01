# encoding: utf-8
$:.unshift(File.dirname(__FILE__))

require 'app/growcontrol'

map '/' do
  run GrowControlApp
end
