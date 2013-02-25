module Songkick
  
  module Spiders
    
    class WeGotTickets < Spider
      
      def scraper
        Songkick::Scrapers::WeGotTickets
      end
      
    end
    
  end
  
end