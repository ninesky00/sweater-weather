class MunchieFacade
  class << self 
    def make_munchies
      Munchie.new
    end
    
    def yelp
      parsed = YelpService.serach_business(destination, term, time)
      restaurant = {name: parsed[:businesses].first[:name],
                    address: parsed[:businesses].first[:location][:display_address]}
    end

    def travel_time(from, to)
      parsed = MapquestService.directions(from, to)
      parsed[:route][:formattedTime]
    end

    def current_forecast(destination)
      parsed = OpenWeatherService.current(destination)
      forecast = {summary: parsed[:weather][:description], 
      temperature: parsed[:main][:temp]}
    end
  end
end