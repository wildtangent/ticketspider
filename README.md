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
require './lib/songkick'
url = "http://www.wegottickets.com/searchresults/page/1/all"
scraper = Songkick::Scrapers::WeGotTickets.new(url)
scraper.items 
  # => [
    Songkick::ListingItems::WeGotTickets,
    Songkick::ListingItems::WeGotTickets,
    Songkick::ListingItems::WeGotTickets,
    Songkick::ListingItems::WeGotTickets,
    Songkick::ListingItems::WeGotTickets,
    Songkick::ListingItems::WeGotTickets,
    Songkick::ListingItems::WeGotTickets
  ]
scraper.items.first.artist #=> "100 CLUB TUESDAY BLUES FEATURING DERRIN NAUENDORF"
scraper.export_json("events.json")
  # => saves to output/events.json
```

## Implementing the spider
```
require './lib/songkick'
url = "http://www.wegottickets.com/searchresults/page/1/all"
spider = Songkick::Spiders::WeGotTickets.new(url)
spider.run
spider.results 
  # => {
    ....JSON of results
  }
```