module Songkick
  
  module Spiders
    
    class WeGotTickets < Spider
      
      def scraper
        Songkick::Scrapers::WeGotTickets
      end
      
      def scrapers
        @scrapers ||= []
      end
      
      def run
        loop do
          url = @urls.first
          s = scraper.new(url, self)
          scrapers << s
          s.run
          followed_url!(url)
          break if @urls.empty?
        end 
      end
      
    end
    
  end
  
end