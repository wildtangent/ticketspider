module Songkick
  module Scrapers
    class WeGotTickets < Scraper
      
      extend Songkick::Utils::Callbacks
      
      callback :on_url
      callback :on_page_complete
      
      def initialize(url, spider=nil)
        super
        @max_depth = 50
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
        @items ||= []
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
        on_page_complete
        
        @items
      end
      
      # Get the next page and fire the on_url handler
      def next_page!
        page = @doc.css(".paginator span.pagination_current").first
        @next_page = page.next_element["href"] if page
        on_url(@next_page) if @next_page
      end
      
      # Add some callbacks on the model
      def register_callbacks!
        on_url do |url|
          if @spider && @spider.followed_urls.count <= @max_depth
            #puts "Adding url #{url}"
            @spider.add_url(url) 
          else
            #puts "reached maximum depth"
          end
        end
        
        on_page_complete do 
          next_page!
        end
        
      end
  
    end
    
  end
end