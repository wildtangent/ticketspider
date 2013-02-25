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
  
  it 'should not run without implementation' do
    expect { spider.run }.to raise_error
  end    
  
end