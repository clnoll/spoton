# require 'net/http'
require 'open-uri'
require 'nokogiri'

class SpotOn::GetUrls

  def initialize(str)
    @str = str
    # @non_word = non_word
    @urls = []
  end

  def get_urls
    uri = URI.parse(@str)
    get_host = uri.host
    base = URI.parse("http://#{get_host}")
    doc = Nokogiri::HTML(open(base))
    doc.css('a').each {|i| @urls << i['href'] }
    @urls
  end
end
