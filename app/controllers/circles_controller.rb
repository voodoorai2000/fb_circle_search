class CirclesController < ApplicationController
  def index
    @circles = Circle.recent
  end

  def revised
    @circles = Circle.revised
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
