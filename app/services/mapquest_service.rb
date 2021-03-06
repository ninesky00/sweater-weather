class MapquestService
  class << self
    def lat_lng(params)
      response = connection.get('/geocoding/v1/address') do |req|
        req.params[:location] = params[:location]
        req.params[:key] = ENV['MAP_QUEST_KEY']
      end
      parse(response)
    end

    private 

    def parse(data)
      JSON.parse(data.body, symbolize_names: true)
    end

    def connection
      Faraday.new('https://www.mapquestapi.com/')
    end
  end
end