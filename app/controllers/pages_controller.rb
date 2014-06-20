class PagesController < ApplicationController
  before_action :set_page, only: [:show, :edit, :update, :destroy]
  before_filter :parse_facebook_cookies

  def index
    @pages = Page.fresh
  end

  def revised
    @pages = Page.revised
  end
  
  def update
    respond_to do |format|
      if @page.update(page_params)
        format.js { render text: '' }
      else
        raise "Something went wrong"
      end
    end
  end

  def refresh
    @graph = Koala::Facebook::API.new(@access_token)

    fb_pages = @graph.search('podemos', type: 'page')

    fb_pages.each do |fb_page|
      Page.find_or_create_by(fb_page_id: fb_page['id']) do |page|
        page.name = fb_page['name']
      end
    end

    redirect_to pages_url
  end

  private

  def set_page
    @page = Page.find(params[:id])
  end

  def page_params
    params.require(:page).permit(:revised)
  end

  def parse_facebook_cookies
    @access_token ||= Koala::Facebook::OAuth.new(Rails.application.secrets.facebook_app_id, Rails.application.secrets.facebook_secret).get_app_access_token
  end

end
