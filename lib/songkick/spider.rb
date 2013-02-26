module Songkick
  
  # Spider implementation
  # Initialize with a start_url
  # Call #run to step through the urls until complete
  # The next step would be to push the spiders off into a queue
  class Spider
    
    # Raise when no scraper was defined (so can't process anything)
    class  NoScraperError < Exception;end;
    
    require 'uri'
    
    attr_accessor :urls, :followed_urls, :errors
    
    # Create a spider with an optional initial url
    def initialize(start_url=nil)
      @followed_urls = []
      @max_depth = 50
      @errors = []
      add_url(start_url)
    end
    
    # Get or set the url array
    def urls
      @urls ||= []
    end

    # Add a url to the spider
    def add_url(url)
      url = URI.parse(url)
      urls << url unless @followed_urls.include?(url)
    rescue  URI::InvalidURIError
      urls
    end
    
    # Remove an item from the 
    def delete_url(url)
      @urls.delete(url)
    end
    
    # Call once you've followed the url, so we can remove it and log it
    def followed_url!(url)
      delete_url(url)
      @followed_urls << url
    end
    
    # Make sure we've not gone too deep!
    def reached_maximum_depth?
      @followed_urls.count <= @max_depth
    end
    
    # Interface definition for scraper. 
    # Define in subclass e.g. Songkick::Scrapers::MyScraper
    def scraper
      raise NoScraperError, "No scraper class defined. Please implement in the subclass"
    end
    
    # Array of already run scrapers
    def scrapers
      @scrapers ||= []
    end
    
    # Get the results from all the scrapers and turn them into a giant hash
    # Clearly this kind ot technique is going to overflow if we do hundreds of pages
    def results
      items = @scrapers.map(&:items).flatten.compact
      items.map(&:to_hash)
    end
    
    # Loop over the scrapers, adding new URLs as we go.
    def run
      loop do
        print "."
        url = @urls.first
        scr = scraper.new(url, self)
        scrapers << scr
        scr.run
        followed_url!(url)
        break if @urls.empty?
      end
      true
    rescue Exception => e
      @errors << e.to_s
      false
    end
    
  end
  
end