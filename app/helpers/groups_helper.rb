module GroupsHelper
  def facebook_group_url(page)
    "https://www.facebook.com/groups/#{page.group_id}"
  end
end
