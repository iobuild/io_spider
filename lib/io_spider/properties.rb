module IoSpider
  class Properties < Hash
    attr_accessor :name, :selector, :format

    def initialize(name, selector, format)
      @name = name
      @selector = selector
      @format = format
    end

    def method_missing method, *args, &block
      property_name = method.to_s


      property = Property.new(property_name, *args, &block)
      self[property_name] = property

    end


  end
end