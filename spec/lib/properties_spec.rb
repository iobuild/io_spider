require 'spec_helper'

describe 'properties' do
  before {
    @digg_list = Array.new

    @digg_list << IoSpider::Properties.new('articles', 'h2 a', :list)
    @digg_list << IoSpider::Properties.new('title', 'div p', :text)
    @digg_list << IoSpider::Properties.new('repo', 'div', :iterator)
  }

  it 'name list' do
    name_list = @digg_list.map {|d| d.name }
    expect(name_list).to eq(['articles', 'title', 'repo'])
  end

  it 'selector list' do
    selector_list = @digg_list.map {|d| d.selector }
    expect(selector_list).to eq(['h2 a', 'div p', 'div'])
  end

  it 'format list' do
    format_list = @digg_list.map {|d| d.format }
    expect(format_list).to eq([:list, :text, :iterator])
  end

end