module Songkick
  
  # Module for all Scraper subclasses
  module Scrapers
    
    # Implementation of WeGotTickets screen scraper
    # Parses the found items by selecting their CSS
    # Clearly this is pretty brittle if the service changes their HTML code
    # Whenever a URL is discovered in the items, it is added to the url queue
    # This could be used to add more metadata about the item
    # When the page is finished parsing, the on_page_complete event 
    # fires to look for the next page to process by reading the pagination element
    class WeGotTickets < Scraper
      
      @@debug = false
      
      extend Songkick::Utils::Callbacks
      
      callback :on_url
      callback :on_page_complete
      
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
        @items ||= []
        @doc.css(".TicketListing .ListingOuter").each do |item|
          listing = Songkick::ListingItems::WeGotTickets.new(item, self)
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
          if spider?
            log "Adding url #{url}"
            @spider.add_url(url) 
          else
            log "reached maximum depth"
          end
        end
        
        on_page_complete do 
          if spider?
            next_page!
          end
        end
        
      end
      
      def log(message)
        puts message if @@debug
      end
      
      # Whether or not to traverse any deeper
      def spider?
        @spider && @spider.reached_maximum_depth?
      end
  
    end
    
  end
end