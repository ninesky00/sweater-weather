require './lib/weather_format.rb'

class RoadtripFacade
  class << self 
    include WeatherFormat
    def travel_time(from, to)
      parsed = MapquestService.directions(from, to)
      duration = parsed[:route][:realTime] < 10000000 ? parsed[:route][:realTime] : parsed[:route][:formattedTime]
      duration.class == Integer ? duration : timify(duration)
    end

    def arrival_forecast(from, to)
      duration = travel_time(from, to)
      arrival_time = Time.now + duration
      parsed = WeatherFacade.weather(to)
      if duration < 172800
        result = hour_match(parsed, arrival_time)
      else
        result = daily_match(parsed, arrival_time)
      end
      result.empty? ? "no available forecast" : result.slice(:max_temp, :min_temp, :temp, :conditions)
    end

    def timify(formatted_time)
      hours = formatted_time[0..1].to_i
      minutes = formatted_time[3..4].to_i
      seconds = formatted_time[6..7].to_i
      total = (hours * 60 * 60) + (minutes * 60) + seconds
    end

    def hour_match(parsed, arrival_time)
      hourly_forecast = parsed[:hourly].select do |hour| 
        Time.at(hour[:dt]) == arrival_time.at_beginning_of_hour
      end
      format_hourly_weather(hourly_forecast.first)
    end

    def daily_match(parsed, arrival_time)
      daily_forecast = parsed[:daily].select do |daily|
        Time.at(daily[:dt]).to_date == arrival_time.to_date
      end
      format_daily_weather(daily_forecast.first)
    end
  end
end