class Munchie
  attr_reader :destination_city, :travel_time, :forecast, :restaurant
  def initialize(destination, travel_time, forecast, restaurant)
    @destination_city = destination
    @travel_time = travel_time
    @forecast = forecast
    @restaurant = restaurant
  end
end