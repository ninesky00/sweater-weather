require'./lib/weather_format.rb'

class Forecast
  include WeatherFormat
  attr_reader :current_weather, :daily_weather, :hourly_weather
  def initialize(data)
    @current_weather = format_current_weather(data)
    @daily_weather = data[:daily].first(5).map {|daily| format_daily_weather(daily)}
    @hourly_weather = data[:hourly].first(8).map {|hourly| format_hourly_weather(hourly)}
  end
end