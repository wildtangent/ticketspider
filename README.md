# Ticket Spider Scraper

Scrape concert information from the pages and outputs the data in machine readable format of your choice, e.g. JSON, XML, CSV


## Running the tests

Run the specs by calling

```
bundle
rspec .
```


## Implementing the scraper

```
require './lib/ticketspider'
url = "http://www.wegottickets.com/searchresults/page/1/all"
scraper = Ticketspider::Scrapers::WeGotTickets.new(url)
scraper.items 
  # => [
    Ticketspider::ListingItems::WeGotTickets,
    Ticketspider::ListingItems::WeGotTickets,
    Ticketspider::ListingItems::WeGotTickets,
    Ticketspider::ListingItems::WeGotTickets,
    Ticketspider::ListingItems::WeGotTickets,
    Ticketspider::ListingItems::WeGotTickets,
    Ticketspider::ListingItems::WeGotTickets
  ]
scraper.items.first.artist #=> "100 CLUB TUESDAY BLUES FEATURING DERRIN NAUENDORF"
scraper.export_json("events.json")
  # => saves to output/events.json
```

## Implementing the spider
```
require './lib/ticketspider'
url = "http://www.wegottickets.com/searchresults/page/1/all"
spider = Ticketspider::Spiders::WeGotTickets.new(url)
spider.run
spider.results 
  # => {
    ....JSON of results
  }
```