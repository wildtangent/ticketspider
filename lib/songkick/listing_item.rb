module Songkick
  
  # Listing Item used to hold information about and event
  # Can be instancated with attributes hash or by assigning attributes
  # :artist, :price, :city, :venue, :url, :date_time
  class ListingItem
    
    # Basic attributes, artist, price, city, venue and date_time as DateTime object
    attr_accessor :artist, :price, :city, :venue, :url
    attr_reader :date_time
        
    # Initialize by passing in a attributes hash
    def initialize(attributes={})
      @attributes = attributes
      @artist = attributes[:artist]
      @price = attributes[:price]
      @city = attributes[:city]
      @venue = attributes[:venue]
      @url = attributes[:url]
      self.date_time = attributes[:date_time]
    end
    
    # Parse date time value to DateTime object
    # TODO: This is going to need some custom behavour to strip out the different date formats, ranges etc.
    def date_time=(date_time)
      @date_time = DateTime.parse(date_time)
    end
    
    # Cast item to a JSON string
    def to_json
      to_hash.to_json
    end
    
    # Cast item to a hash
    def to_hash
      {
        artist: artist,
        city: city,
        venue: venue,
        price: price,
        date_time: date_time.to_s,
        url: url
      }
    end
    
  end
  
end
