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

        case properties.format
        when :text
          h_list[properties.name] = @page.search(properties.selector).text
        when :list
          list_data = Array.new
          @page.search(properties.selector).each do |t|
            list_data << t.text
          end

          h_list[properties.name] = list_data
        when :iterator
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


        

      end

      # p h_list

      parsers = Hash.new
      parser_list = Array.new
      items = Hash.new

      h_list.keys.each_with_index do |k, index|

        # p k
        h = h_list[k]

        case digg_list[index].format
        when :text
          parsers[k] = h
        when :list
          parsers[k] = h
        when :iterator

          h.first[1].length.times do |i|

            items[i] = Hash.new
            h.keys.each do |kk|
              items[i][kk] = h[kk][i]
            end

            parser_list << items[i]

            # p parser_list
            
          end

          parsers[k] = parser_list

        end

        

      end

      p parsers

      parsers

      
    end

  end
end