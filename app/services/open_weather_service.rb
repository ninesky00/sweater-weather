class OpenWeatherService
  class << self 
    def forecast(latlng)
      response = connection.get('data/2.5/onecall') do |req|
        req.params[:lat] = latlng[:lat]
        req.params[:lon] = latlng[:lng]
        req.params[:exclude] = 'minutely'
        req.params[:units] = 'imperial'
        req.params[:appid] = ENV['OPEN_WEATHER_KEY']
      end
      JSON.parse(response.body, symbolize_names: true)
    end

    def current(destination)
      response = connection.get('/data/2.5/weather') do |req|
        req.params[:q] = destination
        req.params[:units] = 'imperial'
        req.params[:appid] = ENV['OPEN_WEATHER_KEY']
      end
      JSON.parse(response.body, symbolize_names: true)
    end

    private 

    def connection
      Faraday.new('https://api.openweathermap.org')
    end
  end
end