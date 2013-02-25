module Songkick
  
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
      @link = attributes[:url]
      date_time = attributes[:date_time]
    end
    
    # Parse date time value to DateTime object
    # TODO: This is going to need some custom behavour to strip out the different date formats, ranges etc.
    def date_time=(date_time)
      @date_time = DateTime.parse(date_time)
    end
    
    def to_json
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
