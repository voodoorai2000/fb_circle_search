require 'facebook_api_group'
require 'facebook_api_page'
class CirclesController < ApplicationController  
  before_filter :authenticate, only: :search

  def index
    @circles = Circle.recent
  end

  def revised
    @circles = Circle.revised
  end

  def search
    FacebookApiGroup.new(current_user).search
    FacebookApiPage.new.search
    redirect_to circles_url
  end

  def update
    @circle = Circle.find(params[:id])
    @circle.update(circle_params)
  end

  private
    
  def circle_params
    params.require(:circle).permit(:revised)
  end
end
