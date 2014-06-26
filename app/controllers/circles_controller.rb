class CirclesController < ApplicationController
  def index
    @circles = Circle.recent.page(params[:page])
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
