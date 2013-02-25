module Songkick
  
  class Spider
    
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
    
    # Run the spider
    def run
      raise Exception, "Implement in subclass"
    end
    
  end
  
end