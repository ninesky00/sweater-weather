class Forecast
  attr_reader :current_weather, :daily_weather, :hourly_weather
  def initialize(data)
    @current_weather = format_current_weather(data)
    @daily_weather = format_daily_weather(data)
    @hourly_weather = format_hourly_weather(data)
  end

  private

  def format_current_weather(data)
    current = format_time(data[:current])
    other_keys = %i(temp feels_like humidity uvi visibility)
    other = data[:current].slice(*other_keys)
    condition_icon = {conditions: data[:current][:weather].first[:description], 
                      icon: data[:current][:weather].first[:icon]} 
    current.merge!(other).merge!(condition_icon)
  end

  def format_daily_weather(data)
    data[:daily].first(5).map do |daily|
      daily_weather = format_time(daily)
      other_keys = {max_temp: daily[:temp][:max], 
                    min_temp: daily[:temp][:min],
                    conditions: daily[:weather].first[:description],
                    icon: daily[:weather].first[:icon]}
      daily_weather.merge!(other_keys)
    end
  end

  def format_hourly_weather(data)
    data[:hourly].first(8).map do |hourly|
      hourly_weather = {time: DateTime.strptime("#{hourly[:dt]}", '%s'),
                        temp: hourly[:temp].to_f, 
                        conditions: hourly[:weather].first[:description],
                        icon: hourly[:weather].first[:icon]}
    end
  end

  def format_time(time)
    time_keys = %i(dt sunrise sunset)
    keys = time.slice(*time_keys)
    keys.each do |key, val|
      keys[key] = DateTime.strptime("#{val}", '%s')
    end
  end
end