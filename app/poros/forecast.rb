class Forecast
  def initialize(data)
    @current_weather = format_current_weather(data)
    @daily_weather = data[:daily]
    @hourly_weather = data[:hourly]
  end

  def format_current_weather(data)
    time_keys = %i(dt sunrise sunset) 
    current = data[:current].slice(*time_keys)
    current.each do |key, val|
      current[key] = DateTime.strptime("#{val}", '%s')
    end
    other_keys = %i(temp feels_like humidity uvi visibility)
    other = data[:current].slice(*other_keys)
    
    condition_icon = {conditions: data[:current][:weather].first[:description], icon: data[:current][:weather].first[:icon] } 
    current.merge!(other).merge!(condition_icon)
  end
end