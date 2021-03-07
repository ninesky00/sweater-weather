class WeatherFacade
  class << self 
    def lat_lng(location)
      parsed = MapquestService.lat_lng(location)
      coor = parsed[:results][0][:locations][0][:latLng]
    end

    def weather(params)
      parsed = OpenWeatherService.forecast(lat_lng(params))
      forecast = Forecast.new(parsed)
    end
  end
end