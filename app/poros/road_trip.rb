class RoadTrip
  attr_reader :start_city, :end_city, :travel_time, :weather_at_eta
  def initialize(from, to, travel_time, arrival_forecast)
    @start_city = from
    @end_city = to 
    @travel_time = travel_time
    @weather_at_eta = arrival_forecast
  end
end