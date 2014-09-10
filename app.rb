require 'sinatra'
# require "sinatra/json"
# require 'pry-debugger'
require 'json'
set :bind, '0.0.0.0'

get '/url' do
  erb :layout
end

post '/url' do
  @urls = SpotOn::GetUrls.new(params["input-text"]).get_urls
  puts @urls
  erb :result
end
