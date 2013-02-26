module Songkick
  
  # Module for all ListingItem subclasses
  module ListingItems
    
    # Factor out the specific behaviour for creating a WeGotTickets ListingItem
    class WeGotTickets < ListingItem
      
      # Initialize instead with an XML::ELement object
      def initialize(item, scraper=nil)
        @item = item
        link = item.at_css("h3 a")
        @url = link['href']
        @artist = link.text
        @city = item.at_css("p span.venuetown").text.gsub(/:/,'').strip
        @venue = item.at_css("p span.venuename").text
        self.date_time = item.at_css("p").children[3].text
        @price = get_price
        
        # If you wanted to register a callback...
        # scraper.on_url(listing.url)
      end

      
      private
    
      # Parse the price out
      def get_price
        # TODO: Two variations of price at least here, would need improvement
        price = @item.at_css(".searchResultsPrice") || @item.at_css(".ListingPrices")
        price.text
      end
      
      
    end
    
  end
  
end