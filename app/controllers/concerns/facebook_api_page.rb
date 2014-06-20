class FacebookApiPage < FacebookApi
  
  def initialize
    @kind = 'page'
    super
  end

  def token
    app_id       = Rails.application.secrets.facebook_app_id 
    app_secret   = Rails.application.secrets.facebook_secret
    Koala::Facebook::OAuth.new(app_id, app_secret).get_app_access_token
  end

end