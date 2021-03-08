require 'rails_helper'

describe MunchieFacade do 
  describe 'current_forecast' do 
    it "gives current forecast give location" do 
      VCR.use_cassette('retrieves_current_forecast_at_location.yml') do 
        location = 'pueblo, co'
        forecast = MunchieFacade.current_forecast(location)

        expect(forecast).to have_key(:summary)
        expect(forecast).to have_key(:temperature)
      end
    end
  end

  describe "travel time" do 
    it "gives travel time from start to destination" do 
      VCR.use_cassette('retrieves_travel_time_from_start_to_destination.yml') do 
        start = 'denver, co'
        destination = 'pueblo, co'
        travel_time = MunchieFacade.travel_time(start, destination)

        expect(travel_time).to be_a(Numeric)
      end
    end
  end

  describe "yelp", :vcr do 
    it "gives one restaurant recommendation based on destination, food search, and time" do 
      start = 'denver, co '
      destination = 'pueblo, co'
      term = 'hamburgers'
      time = 1615212000
      restaurant = MunchieFacade.yelp(destination, term, time)
      expect(restaurant).to have_key(:name)
      expect(restaurant).to have_key(:address)
    end
  end

  describe "make_munchies", :vcr do 
    it "creates munchie poro based on params" do 
      params = {start: 'denver, co', destination: 'pueblo, co', food: 'hamburgers'}
      munchie = MunchieFacade.make_munchies(params)

      expect(munchie).to be_a(Munchie)
    end
  end
end