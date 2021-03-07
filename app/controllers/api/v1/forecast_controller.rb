class Api::V1::ForecastController < ApplicationController
  def index
    render json: ForecastSerializer.new(WeatherFacade.weather(params[:location]))
  end
end