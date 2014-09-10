require 'net/http'

class SpotOn::GetUrls

  def initialize(str)
    @str = str
    # @non_word = non_word
    @urls = []
  end

  def get_urls
    # resource = Net::HTTP.new(@str).get(@str)
    # headers, data = resource.get('/robots.txt')
    # data
    # resource.get('/index.html')
    # resource
    uri = URI(@str)
    Net::HTTP.get(uri)
  end
end
