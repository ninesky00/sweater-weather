class Api::V1::RoadTripController < ApplicationController
  before_action :params_present?, :key_present?

  def create
    render json: RoadTripSerializer.new(RoadTripFacade.make_road_trip(road_trip_params)), status: 200
  end

  private 

  def params_present?
    render json: {error: 'invalid request'} unless check_params
  end

  def key_present?
    render json: {error: "unauthorized"}, status: 401 unless User.find_by(auth_token: params[:road_trip][:api_key])
  end

  def check_params
    params[:road_trip][:origin].present? && params[:road_trip][:destination].present? && params[:road_trip][:api_key].present?
  end

  def road_trip_params
    params.require(:road_trip).permit(:origin, :destination, :api_key)
  end
end