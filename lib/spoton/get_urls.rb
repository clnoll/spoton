require 'open-uri'
require 'nokogiri'

class SpotOn::GetUrls

  def initialize(str)
    @str = str
    @events = []
    @uri = URI.parse(@str)
    @host = @uri.host
    @split_str = @str.split('/')
    @base = URI.parse("http://#{@host}")
  end

  def get_urls
    urls = []

    # Open the page associated with the base url of the event
    html_doc = Nokogiri::HTML(open(@base))

    # Parse through to identify urls, and add to urls array
    html_doc.xpath('//a/@href').each do |i|
        urls << i.content
    end

    # Pass each url through the check_urls method to determine whether they may be valid events
    urls.each do |i|
        check_urls(i)
    end

    # If too few events were returned, crawl through the event pages to identify more
    if @events.length < 10
        crawl_events(@uri)
    end

    # Return the array of event urls
    @events
  end

  def check_urls(i)
    split_url = i.split('/')

    # Compare the root and length of items from the urls array with the original string for similarity
    if split_url[0..2] == @split_str[0..2] && split_url.length == @split_str.length || split_url.length == @split_str.length - 2
        i[0..3] == 'http' ? @events << i : @events << "http://#{@host}#{i}"
    # Check for 'event' in items from urls array, check against original string for similarity
    elsif /(event)/.match(i) && split_url.length == @split_str.length || split_url.length == @split_str.length - 2
        i[0..3] == 'http' ? @events << i : @events << "http://#{@host}#{i}"
    end
  end

  def crawl_events(uri)
    i = 0
    while @events.length < 10
        i += 1
        urls = []

        # This time pass in the original string instead of its host site
        html_doc = Nokogiri::HTML(open(uri))
        html_doc.xpath('//a/@href').each do |i|
            urls << i.content
        end

        urls.each do |i|
            check_urls(i)
        end
        crawl_events(@events[i])
    end
  end

end
