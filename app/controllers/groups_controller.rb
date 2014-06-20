class GroupsController < ApplicationController
  def index
    @groups = Group.all
  end

  def refresh
    user_access_token = Rails.application.secrets.facebook_user_token
    @graph = Koala::Facebook::API.new(user_access_token)

    fb_pages = @graph.search('podemos', type: 'group')

    fb_pages.each do |fb_page|
      Group.find_or_create_by(group_id: fb_page['id']) do |page|
        page.name = fb_page['name']
      end
    end

    redirect_to groups_url
  end
end
