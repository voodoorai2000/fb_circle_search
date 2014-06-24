class FacebookApi

  def initialize(params=nil)
    @circles = []
  end

  def search(query="podemos")
    @query = query
    fb_authenticate
    fb_search
    store
  end

  def fb_authenticate
    @graph = Koala::Facebook::API.new(token)
  end

  def fb_search    
    @circles += @graph.search(@query, type: @kind)
  end

  def store
    @circles.each do |fb_circle|
      Circle.find_or_create_by(fb_id: fb_circle['id']) do |circle|
        circle.name       = fb_circle['name']
        circle.image_url  = image(fb_circle)
        circle.constituted_at = constituted_at(fb_circle)
        circle.kind       = @kind
      end
    end
  end

  def image(fb_circle)
    pic_cover = @graph.fql_query("select pic_cover from #{@kind} where #{@fb_id}=#{fb_circle['id']}") 
    pic_cover.first["pic_cover"]["source"] if pic_cover.first["pic_cover"].present?
  end

  def constituted_at(fb_circle)
    @posts = @graph.get_connection(fb_circle['id'], posts_table, {:limit => 100})
    until @posts.blank?
     @last_post = @posts.last
     @posts = @posts.next_page
puts "LATTEST POST #{@last_post}"
puts "next_post"     
    end
    @last_post["created_time"] if @last_post.present? #Some groups dont have posts
  end

end