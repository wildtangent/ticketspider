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
    spider.results.count.should == 60
  end
  
  it 'should track all the URLs the spider has visited', :vcr do
    spider.run
    spider.followed_urls.map(&:to_s).should == ["http://www.wegottickets.com/searchresults/page/1/all", "http://www.wegottickets.com/event/206480", "http://www.wegottickets.com/event/206481", "http://www.wegottickets.com/f/5351", "http://www.wegottickets.com/event/203438", "http://www.wegottickets.com/event/200790", "http://www.wegottickets.com/event/192425", "http://www.wegottickets.com/event/195450", "http://www.wegottickets.com/event/199305", "http://www.wegottickets.com/event/207280", "http://www.wegottickets.com/event/207281", "http://www.wegottickets.com/searchresults/page/2/all", "http://www.wegottickets.com/event/198434", "http://www.wegottickets.com/event/198187", "http://www.wegottickets.com/event/208202", "http://www.wegottickets.com/event/201623", "http://www.wegottickets.com/event/198807", "http://www.wegottickets.com/event/205945", "http://www.wegottickets.com/f/4929", "http://www.wegottickets.com/event/210137", "http://www.wegottickets.com/event/196842", "http://www.wegottickets.com/event/196840", "http://www.wegottickets.com/searchresults/page/3/all", "http://www.wegottickets.com/event/196841", "http://www.wegottickets.com/event/198439", "http://www.wegottickets.com/event/198440", "http://www.wegottickets.com/event/199676", "http://www.wegottickets.com/event/201120", "http://www.wegottickets.com/event/201121", "http://www.wegottickets.com/event/202508", "http://www.wegottickets.com/event/197989", "http://www.wegottickets.com/event/182166", "http://www.wegottickets.com/event/210803", "http://www.wegottickets.com/searchresults/page/4/all", "http://www.wegottickets.com/f/5917", "http://www.wegottickets.com/event/200773", "http://www.wegottickets.com/event/208799", "http://www.wegottickets.com/event/200855", "http://www.wegottickets.com/event/207837", "http://www.wegottickets.com/event/205618", "http://www.wegottickets.com/event/199172", "http://www.wegottickets.com/event/204570", "http://www.wegottickets.com/event/198260", "http://www.wegottickets.com/event/199555", "http://www.wegottickets.com/searchresults/page/5/all", "http://www.wegottickets.com/event/192560", "http://www.wegottickets.com/f/5723", "http://www.wegottickets.com/event/207442", "http://www.wegottickets.com/event/206482", "http://www.wegottickets.com/event/206483", "http://www.wegottickets.com/event/202440", "http://www.wegottickets.com/event/202441", "http://www.wegottickets.com/event/184187", "http://www.wegottickets.com/f/5364", "http://www.wegottickets.com/event/202972", "http://www.wegottickets.com/searchresults/page/6/all"]
  end
  

  
end
