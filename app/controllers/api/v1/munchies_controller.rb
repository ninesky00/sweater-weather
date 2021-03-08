class Api::V1::MunchiesController < ApplicationController
  def index
    if params[:destination].present? && params[:start].present? && params[:food].present?
      render json: ForecastSerializer.new(WeatherFacade.weather(params[:location]))
    else
      render status: 400
    end
  end
end