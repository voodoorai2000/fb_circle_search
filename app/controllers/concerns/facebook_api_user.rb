class FacebookApiUser < FacebookApi

  def initialize(current_user)
    @current_user = current_user
    @kind  = 'user'
    @fb_id = 'uid'
    super
  end
  
  def token
    @current_user.oauth_token
  end
end