module Songkick
  
  module Spiders
    
    # Spider implementation for WeGotTickets - just defining the scraper class
    class WeGotTickets < Spider
      
      def scraper
        Songkick::Scrapers::WeGotTickets
      end
      
    end
    
  end
  
end