module IoSpider
  class Property
    attr_accessor :name, :selector, :callback

    def initialize(name, *args, &block)
      @name = name
      @selector = args[0]

      # p @selector
      @callback = block
    end


  end
end