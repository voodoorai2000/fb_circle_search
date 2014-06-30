class CirclesController < ApplicationController
  def index
    @circles = Circle.all.page(params[:page])
  end

  def recent
    @circles = Circle.recent(48.hours.ago)
  end

  def revised
    @circles = Circle.revised.page(params[:page])
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
