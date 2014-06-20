class Circle < ActiveRecord::Base
  default_scope { order('created_at DESC') }

  scope :recent,   -> { where revised: false }
  scope :revised, -> { where revised: true }

  def self.search(current_user=nil)
    page_search
    group_search(current_user)
  end

  def self.group_search(current_user)
    @graph = Koala::Facebook::API.new(current_user.oauth_token)
    store('group')    
  end

  def self.page_search
    @access_token ||= Koala::Facebook::OAuth.new(Rails.application.secrets.facebook_app_id, Rails.application.secrets.facebook_secret).get_app_access_token
    @graph = Koala::Facebook::API.new(@access_token)
    store('page')
  end

  def self.store(kind)
    fb_pages = @graph.search('podemos', type: kind)
    fb_pages.each do |fb_page|
      Circle.find_or_create_by(fb_id: fb_page['id']) do |circle|
        circle.name = fb_page['name']
        circle.kind = kind
      end
    end
  end

end
