# require 'nokogiri'
# require 'open-uri'
require 'mechanize'
require 'io_spider/properties'
require 'io_spider/property'
require 'io_spider/parser'


module IoSpider
  class Digger

    attr_accessor :url, :format, :doc, :page_result

    def initialize(page_result)
      @page_result = page_result
      @format = :text
      @digg_list = Array.new
    end

    def self.dig_url(url)
      mechanize = Mechanize.new
      # mechanize.user_agent_alias = 'Mac Mozilla'
      mechanize.user_agent_alias = 'Windows Chrome'
      page_result = mechanize.get(url)

      self.new(page_result)
    end

    def self.dig_htmldoc(htmldoc)
      page_result = Nokogiri::HTML htmldoc
      self.new(page_result)
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

      # p @digg_list
      
      Parser.new(@page_result).parse(@digg_list)
    end


  end


end
