# encoding: utf-8

require 'spec_helper'

describe Songkick::ListingItem do
  
  it 'should assign the attributes provided on initializing' do
    item = Songkick::ListingItem.new({
      url: "http://roundhouse.com",
      artist: "Cold War Kid",
      price: "£4.99",
      city: "London",
      venue: "Roundhouse",
      date_time: "2013-02-25 18:00"
    })
    item.url.should == "http://roundhouse.com"
    item.artist.should == "Cold War Kid"
    item.price.should == "£4.99"
    item.city.should == "London"
    item.venue.should == "Roundhouse"
    item.date_time.to_s.should == "2013-02-25T18:00:00+00:00"
  end
  
end