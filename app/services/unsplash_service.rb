class UnsplashService
  class << self
    def search_image(query)
      response = connection.get('/search/photos') do |req|
        # binding.pry
        req.headers['Accept-Version'] = 'v1'
        req.params[:query] = query
        req.params[:per_page] = 1
        req.params[:client_id] = ENV['UNSPLASH_API_KEY']
      end
      JSON.parse(response.body, symbolize_names: true)
    end

    private 

    def connection
      Faraday.new('https://api.unsplash.com/')
    end
  end
end