module Ticketspider
  
  # Scraper Base class
  # Implement core features for a screen scraper.
  # Accpets a url and optionally a spider class which will have 
  # additional urls sent to it as they are discovered
  class Scraper
  
    require 'nokogiri'
    require 'open-uri'
    require 'json'
    require 'active_support/core_ext/array'
    require 'active_support/core_ext/hash'
  
    # Access the URL, and raw doc
    attr_accessor :doc, :url, :spider

    # Iniitialze the scraper passing in the start URL
    def initialize(url, spider=nil)
      @url = url
      @spider = spider
      @doc = Nokogiri::HTML(open(@url))
    end
    
    # Return the HTML content of the page
    def content
      @doc.to_s
    end
  
    # Implement items in subclasses to provide functionality
    def items
      []
    end
    alias_method :run, :items
    
    # Cast to JSON string
    def to_json
      to_hash.to_json
    end
     
    # Cast items to hash
    def to_hash
      items.map(&:to_hash)  
    end
    
    # Write the JSON to disk
    def export_json(filename)
      File.open(filename, "w") do |file|
        file.write(self.to_json)
      end
    end
  
  end

end