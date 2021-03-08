class MunchieFacade
  class << self 
    def make_munchies(params)
      # binding.pry
      travel_time = travel_time(params[:start], params[:destination])
      Munchie.new(params[:destination], 
        travel_time, 
        current_forecast(params[:destination]), 
        yelp(params[:destination], params[:food], (Time.now + travel_time).to_i))
    end

    def yelp(destination, term, time)
      # binding.pry
      parsed = YelpService.search_business(destination, term, time)
      restaurant = {name: parsed[:businesses].first[:name],
                    address: parsed[:businesses].first[:location][:display_address]}
    end

    def travel_time(from, to)
      parsed = MapquestService.directions(from, to)
      # parsed[:route][:formattedTime]
      parsed[:route][:realTime]
    end

    def current_forecast(destination)
      parsed = OpenWeatherService.current(destination)
      forecast = {summary: parsed[:weather].first[:description], 
      temperature: parsed[:main][:temp]}
    end
  end
end