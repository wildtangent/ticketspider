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
  
  it 'should collate all the results', :vcr do
    spider.run
    spider.results.count.should == 520
  end
  
  it 'should track all the URLs the spider has visited', :vcr do
    spider.run
    spider.followed_urls.map(&:to_s).should == ["http://www.wegottickets.com/searchresults/page/1/all", "http://www.wegottickets.com/searchresults/page/2/all", "http://www.wegottickets.com/searchresults/page/3/all", "http://www.wegottickets.com/searchresults/page/4/all", "http://www.wegottickets.com/searchresults/page/5/all", "http://www.wegottickets.com/searchresults/page/6/all", "http://www.wegottickets.com/searchresults/page/7/all", "http://www.wegottickets.com/searchresults/page/8/all", "http://www.wegottickets.com/searchresults/page/9/all", "http://www.wegottickets.com/searchresults/page/10/all", "http://www.wegottickets.com/searchresults/page/11/all", "http://www.wegottickets.com/searchresults/page/12/all", "http://www.wegottickets.com/searchresults/page/13/all", "http://www.wegottickets.com/searchresults/page/14/all", "http://www.wegottickets.com/searchresults/page/15/all", "http://www.wegottickets.com/searchresults/page/16/all", "http://www.wegottickets.com/searchresults/page/17/all", "http://www.wegottickets.com/searchresults/page/18/all", "http://www.wegottickets.com/searchresults/page/19/all", "http://www.wegottickets.com/searchresults/page/20/all", "http://www.wegottickets.com/searchresults/page/21/all", "http://www.wegottickets.com/searchresults/page/22/all", "http://www.wegottickets.com/searchresults/page/23/all", "http://www.wegottickets.com/searchresults/page/24/all", "http://www.wegottickets.com/searchresults/page/25/all", "http://www.wegottickets.com/searchresults/page/26/all", "http://www.wegottickets.com/searchresults/page/27/all", "http://www.wegottickets.com/searchresults/page/28/all", "http://www.wegottickets.com/searchresults/page/29/all", "http://www.wegottickets.com/searchresults/page/30/all", "http://www.wegottickets.com/searchresults/page/31/all", "http://www.wegottickets.com/searchresults/page/32/all", "http://www.wegottickets.com/searchresults/page/33/all", "http://www.wegottickets.com/searchresults/page/34/all", "http://www.wegottickets.com/searchresults/page/35/all", "http://www.wegottickets.com/searchresults/page/36/all", "http://www.wegottickets.com/searchresults/page/37/all", "http://www.wegottickets.com/searchresults/page/38/all", "http://www.wegottickets.com/searchresults/page/39/all", "http://www.wegottickets.com/searchresults/page/40/all", "http://www.wegottickets.com/searchresults/page/41/all", "http://www.wegottickets.com/searchresults/page/42/all", "http://www.wegottickets.com/searchresults/page/43/all", "http://www.wegottickets.com/searchresults/page/44/all", "http://www.wegottickets.com/searchresults/page/45/all", "http://www.wegottickets.com/searchresults/page/46/all", "http://www.wegottickets.com/searchresults/page/47/all", "http://www.wegottickets.com/searchresults/page/48/all", "http://www.wegottickets.com/searchresults/page/49/all", "http://www.wegottickets.com/searchresults/page/50/all", "http://www.wegottickets.com/searchresults/page/51/all", "http://www.wegottickets.com/searchresults/page/52/all"]
  end
  

  
end
