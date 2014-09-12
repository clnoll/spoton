require 'sinatra'
require_relative 'lib/spoton.rb'

class SpotOn::App < Sinatra::Application
  configure :development do |c|
    c.set :bind, '10.10.10.10'
  end

  get '/url' do
    erb :get_url
  end

  post '/url' do
    @urls = SpotOn::GetUrls.new(params["input-text"]).get_urls
    puts @urls
    erb :result
  end
end
