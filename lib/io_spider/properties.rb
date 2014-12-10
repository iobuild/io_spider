module IoSpider
  class Properties < Hash
    attr_accessor :name, :selector, :format, :doc

    def initialize(name, *args)
      @name = name
      @selector = args[0]
      @format = args[1]
      @doc = args[2] if args[2]
    end

    def method_missing method, *args, &block
      property_name = method.to_s


      property = Property.new(property_name, *args, &block)
      self[property_name] = property

    end


  end
end