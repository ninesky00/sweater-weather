class MapquestService
  class << self
    def lat_lng(location)
      response = connection.get('/geocoding/v1/address') do |req|
        req.params[:location] = location
        req.params[:key] = ENV['MAP_QUEST_KEY']
      end
      JSON.parse(response.body, symbolize_names: true)
    end

    def directions(from, to)
      response = connection.get('/directions/v2/route') do |req|
        req.params[:from] = from
        req.params[:to] = to
        req.params[:key] = ENV['MAP_QUEST_KEY']
      end
      JSON.parse(response.body, symbolize_names: true)
    end

    private 

    def connection
      Faraday.new('https://www.mapquestapi.com/')
    end
  end
end