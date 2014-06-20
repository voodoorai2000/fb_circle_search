class FacebookApi

  def search
    fb_authenticate
    fb_search
    store
  end

  def fb_authenticate
    @graph = Koala::Facebook::API.new(token)
  end

  def fb_search
    @circles = []
    radicals.each { |radical|
      @circles += @graph.search(radical, type: @kind)
   
      ('a'..'z').to_a.each { |letters|
        @circles += @graph.search("#{radical} #{letters}", type: @kind)
      }
    }
  end

  def store
    @circles.each do |fb_circle|
      Circle.find_or_create_by(fb_id: fb_circle['id']) do |circle|
        circle.name = fb_circle['name']
        circle.kind = @kind
      end
    end
  end

  def radicals
    ["podemos", "podem"]
  end

end