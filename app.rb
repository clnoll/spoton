require 'sinatra'
require 'json'
require_relative 'lib/spoton.rb'
require 'pry-byebug'

set :bind, '0.0.0.0'

get '/url' do
  erb :get_url
end

post '/url' do
  @urls = SpotOn::GetUrls.new(params["input-text"]).get_urls
  puts @urls
  erb :result
end
