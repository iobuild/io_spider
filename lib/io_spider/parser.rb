module IoSpider
  class Parser
    attr_accessor :page

    def initialize(page)
      @page = page
    end

    def parse(digg_list)

      h_list = Array.new
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

        h_list << h

      end

      p h_list

      # keys = properties.keys

      # keys.each_with_index do |k, i|
      #   selector = properties[k].selector
      #   block = properties[k].callback
      #   p top_selector + ' ' + selector

      #   r = @page.search top_selector + ' ' + selector
      #   p r.length
      #   # return
      #   # p @page.search(top_selector + ' ' + selector).first['href'].strip
      #   # t.search('a').first['href'].strip

      #   # temp_arr = Array.new
      #   # @page.search(top_selector).each do |t|
      #   #   t = t.search(selector)
      #   #   if block
      #   #     temp_arr << block.call(t)
      #   #   else
      #   #     temp_arr << t.text
      #   #   end
          
      #   # end

      #   # properties[k] = temp_arr


      # end

      # p properties.values

      # one.zip(two).map{|one,two| {one:one,two:two}}

      # properties
      
    end

  end
end