class FacebookApiGroup < FacebookApi

  def initialize(current_user)
    @current_user = current_user
    @kind = 'group'
    @fb_id = 'gid'
    super
  end
  
  def token
    @current_user.oauth_token
  end

end