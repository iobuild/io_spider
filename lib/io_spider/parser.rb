module IoSpider
  class Parser
    attr_accessor :page

    def initialize(page)
      @page = page
    end

    def parse(digg_list)

      h_list = Hash.new
      h = Hash.new

      digg_list.each do |properties|

        top_selector = properties.selector

        properties.keys.each do |k|

          h[k] = Array.new

          selector = properties[k].selector
          block = properties[k].callback

          @page.search(top_selector).each do |t|
            t = t.search(selector)
            if block
              h[k] << block.call(t)
            else
              h[k] << t.text
            end
            
          end

        end

        h_list[properties.name] = h

      end

      # p h_list

      parser_list = Hash.new

      h_list.keys.each do |k|
        h = h_list[k]
        
        h.first[1].length.times do |i|

          parser_list[i] = Hash.new
          h.keys.each do |kk|
            parser_list[i][kk] = h[kk][i]
          end

          # p parser_list
          
        end

      end

      p parser_list


      # one.zip(two).map{|one,two| {one:one,two:two}}

      # properties
      
    end

  end
end