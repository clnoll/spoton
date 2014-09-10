require 'net/http'

class SpotOn::GetUrls

  def initialize(str)
    @str = str
    # @non_word = non_word
    @urls = []
  end

  def get_urls
    @str
    resource = Net::HTTP.new('stackoverflow.com', '/index.html')
    # headers, data = resource.get('/robots.txt')
    # data
    resource

    uri = URI('http://www.eventbrite.com/')
    Net::HTTP.get(uri)
  end
end
