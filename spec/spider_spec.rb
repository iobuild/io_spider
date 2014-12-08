require 'spec_helper'

describe 'test spider' do
  # it 'test spec' do
  #   r = IoSpider.digg do 
  #     # url 'http://www.weixiyu.com/espanol/exam/'
  #     # css 'div[@class="article"] h2'

  #     hello
  #   end

  #   # r.should eql('whatis')
  # end

  it 'first' do
    url = 'http://www.weixiyu.com/espanol/exam/'
    r = IoSpider::Digger.new(url).digg do

      test_text 'div[@class="wdsi-slide-content"] p', :text

      title_list 'div[@class="article"] h2', :list

      exams 'div[@class="article"]', :iterator do
        title 'h2'
        href  'h2 a' do |h|
          h.first['href'].strip
        end
      end

      # exams1 'div[@class="article"]' do
      #   title 'h2'
      #   href  'h2 a' do |h|
      #     h.first['href'].strip
      #   end
      # end
      
    end

    # p r['title']
    # p r['href']

    p r


  end

end