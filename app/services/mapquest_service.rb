class MapquestService
  class << self
    def lat_lng(params)
      response = connection.get('/geocoding/v1/address') do |req|
        req.params[:location] = params[:location]
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