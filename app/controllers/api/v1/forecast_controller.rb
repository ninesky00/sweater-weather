class Api::V1::ForecastController < ApplicationController
  def index
    if params[:location].present?
      render json: ForecastSerializer.new(WeatherFacade.make_forecast(params[:location]))
    else
      render status: 400
    end
  end
end