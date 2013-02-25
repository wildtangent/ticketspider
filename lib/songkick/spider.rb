module Songkick
  
  class Spider
    
    require 'uri'
    
    attr_accessor :urls, :followed_urls
    
    # Create a spider with an optional initial url
    def initialize(start_url=nil)
      add_url(start_url)
    end

    # Add a url to the spider
    def add_url(url)
      url = URI.parse(url)
      urls << url
    rescue  URI::InvalidURIError
      urls
    end
    
    # Get or set the url array
    def urls
      @urls ||= []
    end
    
    # Run the spider
    def run
      raise Exception, "Implement in subclass"
    end
    
  end
  
end