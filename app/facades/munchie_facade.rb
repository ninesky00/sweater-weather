class MunchieFacade
  class << self 
    def make_munchies(params)
      Munchie.new(params[:destination], 
        travel_time(params[:start], params[:destination]), 
        current_forecast(params[:destination]), 
        yelp(params[:destination], params[:food], Time.now + travel_time(params[:start], params[:destination]))
    end

    def yelp(destination, term, time)
      parsed = YelpService.search_business(destination, term, time)
      restaurant = {name: parsed[:businesses].first[:name],
                    address: parsed[:businesses].first[:location][:display_address]}
    end

    def travel_time(from, to)
      parsed = MapquestService.directions(from, to)
      parsed[:route][:realTime]
    end

    def current_forecast(destination)
      parsed = OpenWeatherService.current(destination)
      forecast = {summary: parsed[:weather].first[:description], 
      temperature: parsed[:main][:temp]}
    end
  end
end