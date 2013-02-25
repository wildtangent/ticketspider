module Songkick
  
  class Spider
    
    class  NoScraperError < Exception;end;
    
    require 'uri'
    
    attr_accessor :urls, :followed_urls
    
    # Create a spider with an optional initial url
    def initialize(start_url=nil)
      @followed_urls = []
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
        url = @urls.first
        s = scraper.new(url, self)
        scrapers << s
        s.run
        followed_url!(url)
        break if @urls.empty?
      end 
    end
    
  end
  
end