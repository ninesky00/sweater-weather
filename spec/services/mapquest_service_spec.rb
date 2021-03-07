require 'rails_helper'

describe MapquestService do 
  describe 'lat_lng' do 
    it "retrieves latitude and longitude given city and state", :vcr do 
      params = {location: "denver, CO"}
      parsed = MapquestService.lat_lng(params)
      parsed_location = parsed[:results].first[:locations].first

      expect(parsed).to be_a(Hash)      
      expect(parsed_location).to have_key(:latLng)
    end
  end
end