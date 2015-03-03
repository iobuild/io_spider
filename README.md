# IoSpider

io_spider is a crawler with an elegant DSL that parses structured data from web pages.



## Installation

Add this line to your application's Gemfile:

```ruby
gem 'io_spider', :git => 'git://github.com/iobuild/io_spider.git'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install io_spider


## Usage:

Obs: Requires ruby 1.9.3 (activesupport requires Ruby version >= 1.9.3)


```ruby
require 'io_spider'

IoSpider::Digger.dig_htmldoc(htmldoc).digg do

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


or


IoSpider::Digger.dig_url(url).digg do

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
```

###### The code above is gonna return the following hash:

```ruby
{
  :test_text=>"El que domina a los otros es fuerte pero el que se domina a si mismo es poderoso.胜人者有力，自胜者强", 

  :title_list=>
    [
      "西班牙语专四真题：2005-2013年 下载", 
      "下载：2013年西班牙语专四试题及答案", 
      "2014年西班牙语专业四级测试试题框架", 
      "DELE 考试成绩查询方法", "全国西班牙语翻译专业资格考试", 
      "2014年西班牙语专四专八考试时间", 
      "2014年西班牙语DELE考试时间费用与报名方法"
    ], 

  :exams=>
    [
      {:title=>"西班牙语专四真题：2005-2013年 下载", :href=>"http://www.spanish.com/2005-2013/"}, 
      {:title=>"下载：2013年西班牙语专四试题及答案", :href=>"http://www.spanish.com/2013-4/"}, 
      {:title=>"2014年西班牙语专业四级测试试题框架", :href=>"http://www.spanish.com/4/"}, 
      {:title=>"DELE 考试成绩查询方法", :href=>"http://www.spanish.com/dele2/"}, 
      {:title=>"全国西班牙语翻译专业资格考试", :href=>"http://www.spanish.com/catti/"}, 
      {:title=>"2014年西班牙语专四专八考试时间", :href=>"http://www.spanish.com/48/"}, 
      {:title=>"2014年西班牙语DELE考试时间费用与报名方法", :href=>"http://www.spanish.com/dele/"}
    ]
}
```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/io_spider/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request


## Contributors

 * Arly Xiao ([@arlyxiao](https://github.com/arlyxiao))
 * [List of all contributors](https://github.com/iobuild/io_spider/graphs/contributors)
