require "io_spider/version"
require "io_spider/digger"

module IoSpider

  class << self

    def digg(&block)
      klass = Class.new
      klass.send(:include, IoSpider::Digger)
      klass.new.digg(&block)
    end
  end


end
