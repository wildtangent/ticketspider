module Songkick
  module Scrapers
    class WeGotTickets < Scraper
      
      extend Songkick::Utils::Callbacks
      
      callback :on_url
      
      def initialize(url, spider=nil)
        super
        register_callbacks!
      end
      
      # Set the items
      def items
        @items ||= parse_items
      end
      alias_method :run, :items
      
      private
    
      # Parse the items using Nokogiri and return an array of ListingItems
      def parse_items
        @items = []
        @doc.css(".TicketListing .ListingOuter").each do |item|
          listing = Songkick::ListingItem.new
          listing.url = item.at_css("h3 a")['href']
          on_url(listing.url)
          
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
      
      # Add some callbacks on the model
      def register_callbacks!
        on_url do |url|
          @spider.add_url(url) if @spider
        end
      end
  
    end
    
  end
end