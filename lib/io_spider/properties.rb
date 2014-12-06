module IoSpider
  class Properties < Hash
    attr_accessor :name, :selector

    def initialize(name, selector)
      @name = name
      @selector = selector
    end

    def method_missing method, *args, &block
      property_name = method.to_s

      # p property_name
      # @selector = args[0]
      # p @selector
      # self.instance_eval &block if block_given? 

      property = Property.new(property_name, *args, &block)
      self[property_name] = property

    end


  end
end