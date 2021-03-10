module WeatherFormat
  def format_current_weather(data)
    current = format_time(data[:current])
    other_keys = %i(temp feels_like humidity uvi visibility)
    other = data[:current].slice(*other_keys)
    condition_icon = {conditions: data[:current][:weather].first[:description], 
                      icon: data[:current][:weather].first[:icon]} 
    current.merge!(other).merge!(condition_icon)
  end

  def format_daily_weather(daily)
    daily_weather = format_time(daily)
    other_keys = {max_temp: daily[:temp][:max], 
                  min_temp: daily[:temp][:min],
                  conditions: daily[:weather].first[:description],
                  icon: daily[:weather].first[:icon]}
    daily_weather.merge!(other_keys)
  end

  def format_hourly_weather(hourly)
    hourly_weather = {time: Time.at(hourly[:dt]),
                      temp: hourly[:temp].to_f, 
                      conditions: hourly[:weather].first[:description],
                      icon: hourly[:weather].first[:icon]}
  end

  def format_time(time)
    time_keys = %i(dt sunrise sunset)
    keys = time.slice(*time_keys)
    keys.each do |key, val|
      keys[key] = Time.at(val)
    end
  end
end