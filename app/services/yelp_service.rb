class YelpService
  class << self 
    def search_business(destination, term, time)
      response = connection.get('v3/businesses/search?') do |req|
        req.headers[:authorization] = "Bearer #{ENV['YELP_API_KEY']}"
        req.params[:location] = destination
        req.params[:term] = term
        req.params[:open_at] = time
        req.params[:limit] = 1
      end
      JSON.parse(response.body, symbolize_names: true)
    end

    private 

    def connection
      Faraday.new('https://api.yelp.com')
    end
  end
end