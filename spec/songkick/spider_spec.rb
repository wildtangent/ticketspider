require 'spec_helper'

describe Songkick::Spider do
  
  let :spider do
    Songkick::Spider.new(url)
  end
  
  let :url do
    "http://www.wegottickets.com/searchresults/page/1/all"
  end
  
  it 'should instanciate with a URL' do
    spider.urls.first.to_s.should == url
  end
  
  it 'should not add an invalid URL' do
    spider.add_url("\\invalid")
    spider.urls.last.to_s.should_not == "\\invalid"
  end
  
  it 'should raise an exception if the spider is not subclassed with a scraper class' do
    expect { spider.scraper }.to raise_error
end

  # Too tired to make this work :(
  # it 'should catch an exception while running and log it to errors' do
  #   spider.should_receive(:run).exactly(:once).and_raise(Exception)
  #   spider.run
  #   spider.errors.should_not be_empty
  # end
  
end