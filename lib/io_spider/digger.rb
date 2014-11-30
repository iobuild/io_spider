module IoSpider
  module Digger

    
    def digg(&block)

      instance_eval do
        def method_missing method, *args, &block
          p 'hello'
        end
      end
      self.instance_eval &block

    end

  end
end