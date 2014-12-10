module IoSpider
  class Property
    attr_accessor :name, :selector, :doc, :callback

    def initialize(name, *args, &block)
      @name = name
      @selector = args[0]
      @doc = args[1] if args[1]

      @callback = block
    end


  end
end