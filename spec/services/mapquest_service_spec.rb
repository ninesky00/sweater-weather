require 'rails_helper'

describe MapquestService do 
  describe 'lat_lng' do 
    it "converts city state into latitude and longitude coordinates", :vcr do 
      params = {location: "denver, CO"}
      parsed = MapquestService.lat_lng(params)
      parsed_location = parsed[:results].first[:locations].first

      expect(parsed).to be_a(Hash)      
      expect(parsed_location).to have_key(:latLng)

      # parsed[:results][0][:locations][0][:latLng][:lat]
      # parsed[:results][0][:locations][0][:latLng][:lng]
    end
  end
end