# require 'net/http'
require 'open-uri'
require 'nokogiri'

class SpotOn::GetUrls

  def initialize(str)
    @str = str
    # @non_word = non_word
    @urls = []
    @events = {}
  end

  def get_urls
    uri = URI.parse(@str)
    host = uri.host
    parse_str = @str.split('/')
    base = URI.parse("http://#{host}")
    doc = Nokogiri::HTML(open(base))
    doc.css('a').each  do |i|
        split_event_url = i['href'].split('/')
        if split_event_url[0..2] == parse_str[0..2] && i['href'] != "http://#{host}"
            @urls << split_event_url
        end
    end
    @urls
    # parse_str
  end
end
