class WeatherFacade
  class << self 
    def lat_lng(params)
      parsed = MapquestService.lat_lng(params)
      coor = parsed[:results][0][:locations][0][:latLng]
    end

    def weather(params)
      parsed = OpenWeatherService.forecast(lat_lng(params))
      forecast = Forecast.new(parsed)
      binding.pry
    end

    private 

    def format_current_weather(parsed)
      time_keys = %i(dt sunrise sunset) 
      current = parsed[:current].slice(*time_keys)
      current.each do |key, val|
        current[key] = DateTime.strptime("#{val}", '%s')
      end
      other_keys = %i(temp feels_like humidity uvi visibility)
      other = parsed[:current].slice(*other_keys)
      
      condition_icon = {conditions: parsed[:current][:weather].first[:description], icon: parsed[:current][:weather].first[:icon] } 
      current.merge!(other).merge!(condition_icon)
    end
  end
end