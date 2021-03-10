class WeatherFacade
  class << self 
    def lat_lng(location)
      parsed = MapquestService.lat_lng(location)
      parsed[:results][0][:locations][0][:latLng]
    end

    def weather(params)
      OpenWeatherService.forecast(lat_lng(params))
    end

    def make_forecast(params)
      Forecast.new(weather(params))
    end
  end
end