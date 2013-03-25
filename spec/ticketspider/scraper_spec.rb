require 'spec_helper'

describe Ticketspider::Scraper do
  
  let :scraper do
    Ticketspider::Scraper.new("http://www.wegottickets.com/searchresults/page/1/all")
  end
  
  it 'should return a Nokogiri object', :vcr do
    scraper.doc.should be_kind_of(Nokogiri::HTML::Document)
  end
  
  it 'should get some page content', :vcr do
    scraper.content.should_not be_nil
  end
  
  it 'should return no items', :vcr do
    scraper.items.should be_empty
  end
  
  
end