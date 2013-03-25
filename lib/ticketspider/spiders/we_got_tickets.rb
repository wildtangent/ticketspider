module Ticketspider
  
  module Spiders
    
    # Spider implementation for WeGotTickets - just defining the scraper class
    class WeGotTickets < Spider
      
      def scraper
        Ticketspider::Scrapers::WeGotTickets
      end
      
    end
    
  end
  
end