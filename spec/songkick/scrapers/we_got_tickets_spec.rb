# encoding: utf-8 
require 'spec_helper'

describe Songkick::WeGotTickets do
  
  let :scraper do
    Songkick::WeGotTickets.new(start_url)
  end
  
  let :start_url do
    "http://www.wegottickets.com/searchresults/page/1/all"
  end
  
  it 'should return some concert items', :vcr do
    scraper.items.should_not be_empty
  end
  
  it 'should give the link to the page', :vcr do
    scraper.items.map(&:url).should include("http://www.wegottickets.com/event/206480")
  end
  
  it 'should have an artist called "Aimless"', :vcr do
    scraper.items.map(&:artist).should include("AIMLESS")
  end
  
  it 'should have an venue called "100 Club"', :vcr do
    scraper.items.map(&:venue).should include("100 Club")
  end
  
  it 'should have city of READING', :vcr do
    scraper.items.map(&:city).should include("READING")
  end
  
  it 'sohuld have a date of Monday 25th Feb 2013 at 18:30PM', :vcr do
    scraper.items.collect{|item| item.date_time.to_s }.should include DateTime.parse("2013-02-25 18:30").to_s
  end
  
  it 'should have a price', :vcr do
    scraper.items.map(&:price).should include("£10.00")
  end
  
  it 'should return some json', :vcr do
    scraper.to_json.should include '"artist":"BASSMENT PROJECT"'
  end
  
  it 'should return a hash', :vcr do
    scraper.to_hash[0][:city].should == "OXFORD"
  end
  
  it 'should return any item as JSON', :vcr do
    scraper.items.first.to_json.should include '"artist":"2001. A SPACE ODYSSEY"'
  end
  
  it 'should write a file to disk', :vcr do
    filename = "output/we_got_tickets.json"
    scraper.export_json(filename)
    File.open(filename) do |file|
      file.read.should == scraper.to_json      
    end
    FileUtils.rm(filename)
  end
  
end