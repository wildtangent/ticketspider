module Songkick
  class Scraper
  
    require 'nokogiri'
    require 'open-uri'
    require 'json'
    require 'active_support/core_ext/array'
    require 'active_support/core_ext/hash'
  
    # Access the URL, content and raw doc
    attr_accessor :content, :doc, :url

    # Iniitialze the scraper passing in the start URL
    def initialize(url)
      @url = url
      @content = nil
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
    
    # Cast to JSON string
    def to_json
      to_hash.to_json
    end
     
    # Cast items to hash
    def to_hash
      items.map(&:to_hash)  
    end
  
  end

end