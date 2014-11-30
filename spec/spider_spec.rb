require 'spec_helper'

describe 'test spider' do
  it 'test spec' do
    r = IoSpider.digg do 
      loveu
    end

    r.should eql('hello')
  end
end