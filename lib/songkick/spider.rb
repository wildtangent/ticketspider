module Songkick
  
  class Spider
    
    attr_accessor :scraper
    
    def initialize(scraper)
      @scraper = scraper
    end
    
    def run
      raise Exception, "Implement in subclass"
    end
    
  end
  
end