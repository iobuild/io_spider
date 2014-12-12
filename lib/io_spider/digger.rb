# require 'nokogiri'
# require 'open-uri'
require 'mechanize'
require 'io_spider/properties'
require 'io_spider/property'
require 'io_spider/parser'


module IoSpider
  class Digger

    attr_accessor :url, :format, :doc

    def initialize(url)
      @url = url
      @format = :text
      @digg_list = Array.new
    end

    def digg(&block)
      
      instance_eval do

        def method_missing method, *args, &block

          @format = args[1] if args[1]
          @properties = Properties.new(method.to_s, args[0], @format)
          @properties.doc = args[2] if args[2]

          @properties.instance_eval &block if block_given? 

          @digg_list << @properties

        end
      end
      self.instance_eval &block

      mechanize = Mechanize.new
      mechanize.user_agent_alias = 'Mac Mozilla'
      page = mechanize.get(@url)

      
      Parser.new(page).parse(@digg_list)

    end


  end


end
