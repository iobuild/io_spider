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

          properties_name = properties.name.to_sym
          case properties.format
          when :text
            context = @page.search(properties.selector)
            doc = properties.doc
            search_result[properties_name] = get_by_doc(context, doc)
          when :list
            list_data = Array.new
            @page.search(properties.selector).each do |t|
              list_data << get_by_doc(t, properties.doc)
            end

            search_result[properties_name] = list_data
          when :iterator

            search_result[properties_name] = get_iterator_list(properties)
            
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
            
            parsers[k] = rebuild_iterator_list(parse_result)

          end

        end
        # end of search_result each

        parsers
      end


      def get_iterator_list(properties)

        properties.keys.reduce({}) do |res, property_name|

          elements = search_by_properties(properties, property_name)

          res.merge!( property_name => elements)

        end

      end


      def get_by_doc(context, doc)
        case doc
        when :inner_html
          context.inner_html
        else
          context.text
        end
      end



      def search_by_properties(properties, property_name)
        top_selector = properties.selector
        selector = properties[property_name].selector
        block = properties[property_name].callback
        doc = properties[property_name].doc

        @page.search(top_selector).map do |t|
          t = t.search(selector) unless selector.nil?
          block ? block.call(t) : get_by_doc(t, doc)        
        end
      end


      def rebuild_iterator_list(parse_result)

        keys = parse_result.keys
        arrays = parse_result.values

        klass = Struct.new(*keys.map(&:to_sym))
        arrays.reduce(&:zip).map{|tup| klass.new(*tup.flatten)}.map(&:to_h)
      end


  end
end