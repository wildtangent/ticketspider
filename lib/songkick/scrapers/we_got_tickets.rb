module Songkick
  class WeGotTickets < Scraper
  
    # Set the items
    def items
      @items ||= parse_items
    end
    
    # Parse the items using Nokogiri and return an array of ListingItems
    def parse_items
      @items = []
      @doc.css(".TicketListing .ListingOuter").each do |item|
        listing = Songkick::ListingItem.new
        listing.url = item.at_css("h3 a")['href']
        listing.artist = item.at_css("h3 a").text
        listing.city = item.at_css("p span.venuetown").text.gsub(/:/,'').strip
        listing.venue = item.at_css("p span.venuename").text
        listing.date_time = item.at_css("p").children[3].text
        
        # TODO: Two variations of price at least here, would need improvement
        price = item.at_css(".searchResultsPrice")
        price = item.at_css(".ListingPrices") if price.nil?
        listing.price = price.text
        
        @items << listing
      end
      @items
    end
  
  end
end