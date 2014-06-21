class FacebookApi

  def initialize(params=nil)
    @circles = []
  end

  def search
    fb_authenticate
    fb_search
    store
  end

  def fb_authenticate
    @graph = Koala::Facebook::API.new(token)
  end

  def fb_search    
    search_radical
    search_letter_combination
  end

  def store
    @circles.each do |fb_circle|
      
      Circle.find_or_create_by(fb_id: fb_circle['id']) do |circle|
        circle.name      = fb_circle['name']
        circle.image_url = image(fb_circle)
        circle.kind      = @kind
      end
    end
  end

  def radicals
    ["podemos", "podem"]
  end

  def search_radical
    radicals.each do |radical|
      @circles += @graph.search(radical, type: @kind)
    end
  end

  def search_letter_combination
    radicals.each do |radical|
      ('a'..'z').to_a.each do |letters|
        @circles += @graph.search("#{radical} #{letters}", type: @kind)
      end
    end
  end

  def image(fb_circle)
    pic_cover = @graph.fql_query("select pic_cover from group where gid=#{fb_circle['id']}") 
    pic_cover.first["pic_cover"]["source"] if pic_cover.first["pic_cover"].present?
  end

end