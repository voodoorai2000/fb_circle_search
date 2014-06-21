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
    @circles += @graph.search("podemos", type: @kind)
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

  def image(fb_circle)
    pic_cover = @graph.fql_query("select pic_cover from #{@kind} where #{@fb_id}=#{fb_circle['id']}") 
    pic_cover.first["pic_cover"]["source"] if pic_cover.first["pic_cover"].present?
  end

end