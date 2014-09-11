require 'sinatra'
require 'json'
require_relative 'lib/spoton.rb'

set :bind, '10.10.10.10'

get '/url' do
  erb :get_url
end

post '/url' do
  @urls = SpotOn::GetUrls.new(params["input-text"]).get_urls
  puts @urls
  erb :result
end
