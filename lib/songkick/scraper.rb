module Songkick
  class Scraper
  
    require 'nokogiri'
    require 'open-uri'
    require 'json'
  
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
    
    # TODO: need to cast to JSON string
    def to_json
      items JSON.parse(items.map(&:to_json))
    end
  
  end

end