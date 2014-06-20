class FacebookApi

  def initialize
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
        circle.name = fb_circle['name']
        circle.kind = @kind
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
        @circles += @graph.search("#{@radical} #{letters}", type: @kind)
      end
    end
  end

end