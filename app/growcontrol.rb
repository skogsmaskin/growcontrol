require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/twitter-bootstrap'
require 'haml'
require_relative '../config/environment'

  
class GrowControlApp < Sinatra::Base

  register Sinatra::Twitter::Bootstrap::Assets

  register Sinatra::Reloader if $config[:environment] == "development"

  use Rack::Auth::Basic, $config[:http_auth][:text] do |u, p|
    u == $config[:http_auth][:username]
    p == $config[:http_auth][:password]
  end

  set :public_folder, File.dirname(__FILE__) + '/assets'

  get '/' do
    @biosphere ||= GrowControl::Biosphere.new
    haml :biosphere, :locals => {:biosphere => @biosphere}
  end

  get '/images/:kind/:version' do |kind, version|
    file = File.join($config[:image_path], "#{kind}_#{version}.png")
    if File.exists?(file)
      headers "Content-Type" => "image/png"
      File.read(file)
    else
      halt 404, "No such image file"
    end
  end

  get '/images/webcam' do
    headers "Content-Type" => "image/jpeg"
    File.read(File.join($config[:image_path], "webcam.jpeg"))
  end

end
