class WeatherFacade
  class << self 
    def lat_lng(location)
      parsed = MapquestService.lat_lng(location)
      parsed[:results][0][:locations][0][:latLng]
    end

    def weather(params)
      Forecast.new(OpenWeatherService.forecast(lat_lng(params)))
    end
  end
end