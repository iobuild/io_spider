# require 'nokogiri'
# require 'open-uri'
require 'mechanize'
require 'io_spider/properties'
require 'io_spider/property'
require 'io_spider/parser'


module IoSpider
  class Digger

    attr_accessor :url, :format

    def initialize(url, format)
      @url = url
      @format = format
      @digg_list = Array.new
    end

    def digg(&block)
      
      instance_eval do

        def method_missing method, *args, &block

          @properties = Properties.new(method.to_s, args[0], @format)

          @properties.instance_eval &block if block_given? 

          @digg_list << @properties

        end
      end
      self.instance_eval &block

      # p @digg_list
      # p @digg_list[0].selector
      # p @digg_list[0].name
      # p @digg_list[0].keys

      page = Mechanize.new.get(@url)
      Parser.new(page).parse(@digg_list)

    end


  end


end
