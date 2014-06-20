class FacebookApiGroup < FacebookApi

  def initialize(current_user)
    @current_user = current_user
    @kind = 'group'
  end
  
  def token
    @current_user.oauth_token
  end

end