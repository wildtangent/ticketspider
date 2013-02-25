# encoding: utf-8 
require 'spec_helper'

describe Songkick::Spiders::WeGotTickets do
  
  let :spider do
    Songkick::Spiders::WeGotTickets.new(url)
  end
  
  let :url do
    "http://www.wegottickets.com/searchresults/page/1/all"
  end
  
  it 'should be allowed to run', :vcr do
    expect {spider.run }.not_to raise_exception 
  end
  
  it 'should have no URLs left at the end of the run', :vcr do
    spider.run
    spider.urls.should be_empty
  end
  
  it 'should track all the URLs the spider has visited', :vcr do
    spider.run
    spider.followed_urls.map(&:to_s).should == ["http://www.wegottickets.com/searchresults/page/1/all", "http://www.wegottickets.com/event/206480", "http://www.wegottickets.com/event/206481", "http://www.wegottickets.com/f/5351", "http://www.wegottickets.com/event/203438", "http://www.wegottickets.com/event/200790", "http://www.wegottickets.com/event/192425", "http://www.wegottickets.com/event/195450", "http://www.wegottickets.com/event/199305", "http://www.wegottickets.com/event/207280", "http://www.wegottickets.com/event/207281"]
  end
  
end
