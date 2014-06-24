require 'facebook_api_group'
require 'facebook_api_page'
require 'facebook_api_user'
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

  def by_andrex
    File.open("#{Rails.root}/lib/revised_circles.txt", "r") do |f|
      f.each_line do |name|
        ["podemos", "podem"].each do |radical|
          FacebookApiGroup.new(current_user).search("#{radical} #{name}")
          FacebookApiPage.new.search("#{radical} #{name}")
        end
      end
    end
    redirect_to circles_url
  end

  private
    
  def circle_params
    params.require(:circle).permit(:revised)
  end
end
