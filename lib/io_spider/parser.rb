module IoSpider
  class Parser
    attr_accessor :page, :digg_list

    def initialize(page)
      @page = page
    end

    def parse(digg_list)
      @digg_list = digg_list
      
      search_result = get_search_result(digg_list)

      # p search_result

      
      parsers = rebuild_search_result(search_result)

      # p parsers

      parsers

      
    end


    private 
      def get_search_result(digg_list)

        search_result = Hash.new

        digg_list.each do |properties|

          case properties.format
          when :text
            search_result[properties.name] = @page.search(properties.selector).text
          when :list
            list_data = Array.new
            @page.search(properties.selector).each do |t|
              list_data << t.text
            end

            search_result[properties.name] = list_data
          when :iterator
            iterator_list = Hash.new

            top_selector = properties.selector

            properties.keys.each do |property_name|

              iterator_list[property_name] = Array.new

              selector = properties[property_name].selector
              block = properties[property_name].callback

              @page.search(top_selector).each do |t|
                t = t.search(selector)
                if block
                  iterator_list[property_name] << block.call(t)
                else
                  iterator_list[property_name] << t.text
                end
                
              end

            end

            search_result[properties.name] = iterator_list
            
          end

        end
        # end of digg_list each

        search_result

      end

      def rebuild_search_result(search_result)
        parsers = Hash.new

        search_result.keys.each_with_index do |k, index|

          parse_result = search_result[k]

          case @digg_list[index].format
          when :text
            parsers[k] = parse_result
          when :list
            parsers[k] = parse_result
          when :iterator

            iterator_list = Array.new
            items = Hash.new

            parse_result.first[1].length.times do |i|

              items[i] = Hash.new
              parse_result.keys.each do |kk|
                items[i][kk] = parse_result[kk][i]
              end

              iterator_list << items[i]
              
            end

            parsers[k] = iterator_list

          end

        end
        # end of search_result each

        parsers
      end


  end
end