require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/twitter-bootstrap'
require 'haml'
  
class GrowControlApp < Sinatra::Base

  register Sinatra::Twitter::Bootstrap::Assets
  #register Sinatra::Reloader

  set :public_folder, File.dirname(__FILE__) + '/assets'

  use Rack::Auth::Basic, "Hi! How are you?" do |username, password|
    username == 'perlite' && password == 'soil'
  end

  get '/' do
    haml :index
  end

  get '/images/:kind/:version' do |kind, version|
    headers "Content-Type" => "image/png"
    File.read("public/#{kind}_#{version}.png")
  end

  get '/images/webcam' do
    headers "Content-Type" => "image/jpeg"
    File.read("public/webcam.jpeg")
  end

end
