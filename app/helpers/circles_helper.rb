module CirclesHelper
  def facebook_circle_url(circle)
    send("facebook_#{circle.kind}_url", circle)
  end

  def facebook_group_url(circle)
    "#{facebook_url}/groups/#{circle.fb_id}"
  end

  def facebook_page_url(circle)
    "#{facebook_url}/pages/anything/#{circle.fb_id}"
  end

  def facebook_user_url(circle)
    "#{facebook_url}/app_scoped_user_id/#{circle.fb_id}"
  end

  def facebook_url
    "https://www.facebook.com"
  end
end
