require 'rails_helper'

describe WeatherFacade do 
  describe 'lat_lng' do 
    it "converts city and state location into latitude and longitude" do 
      VCR.use_cassette('retrieves_latitude_and_longitude_given_city_and_state.yml') do 
        params = {location: 'denver, CO'}
        lat_lng = WeatherFacade.lat_lng(params)
        expect(lat_lng.keys.count).to eq(2)
        expect(lat_lng).to have_key(:lat)
        expect(lat_lng).to have_key(:lng)
      end
    end
  end

  describe 'weather' do 
    it 'creates forecast object from open weather forecast', :vcr do 
      params = {location: 'denver, CO'}
      WeatherFacade.weather(params)
    end
  end
end