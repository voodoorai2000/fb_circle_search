class FacebookAPI
  
  def initialize(current_user)
    @current_user = current_user    
  end

  def search
    ['page', 'group'].each do |kind|
      fb_search(kind)
      store(kind)
    end
  end

  def fb_search(kind)
    fb_authenticate(kind)
    @circles = @graph.search('podemos', type: kind)
  end

  def store(kind)
    @circles.each do |fb_circle|
      Circle.find_or_create_by(fb_id: fb_circle['id']) do |circle|
        circle.name = fb_circle['name']
        circle.kind = kind
      end
    end
  end

  def fb_authenticate(kind)
    token = kind == 'group' ? user_token : access_token
    @graph = Koala::Facebook::API.new(token)
  end

  def user_token
    @current_user.oauth_token
  end

  def access_token
    app_id       = Rails.application.secrets.facebook_app_id 
    app_secret   = Rails.application.secrets.facebook_secret
    Koala::Facebook::OAuth.new(app_id, app_secret).get_app_access_token
  end

end