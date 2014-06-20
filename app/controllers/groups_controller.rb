class GroupsController < ApplicationController
  def index
    @groups = Group.all
  end

  def refresh
    @graph = Koala::Facebook::API.new(current_user.oauth_token)

    fb_pages = @graph.search('podemos', type: 'group')

    fb_pages.each do |fb_page|
      Group.find_or_create_by(group_id: fb_page['id']) do |page|
        page.name = fb_page['name']
      end
    end

    redirect_to groups_url
  end

end
