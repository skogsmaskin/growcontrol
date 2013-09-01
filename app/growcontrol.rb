require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/twitter-bootstrap'
require 'haml'
require_relative '../config/environment'

  
class GrowControlApp < Sinatra::Base

  HTTP_AUTH_TXT ||= 'Please enter your username and password'

  register Sinatra::Twitter::Bootstrap::Assets

  register Sinatra::Reloader

  use Rack::Auth::Basic, HTTP_AUTH_TXT do |u, p|
    u == $config[:http_auth][:username]
    p == $config[:http_auth][:password]
  end

  set :public_folder, File.dirname(__FILE__) + '/assets'

  get '/' do
    haml :index
  end

  get '/biosphere' do
    @biosphere ||= GrowControl::Biosphere.new
    haml :biosphere
  end

  get '/images/:kind/:version' do |kind, version|
    headers "Content-Type" => "image/png"
    File.read(File.join($config[:image_path], "#{kind}_#{version}.png"))
  end

  get '/images/webcam' do
    headers "Content-Type" => "image/jpeg"
    File.read(File.join($config[:image_path], "webcam.jpeg"))
  end

end
