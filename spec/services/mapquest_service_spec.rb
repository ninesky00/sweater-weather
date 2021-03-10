require 'rails_helper'

describe MapquestService do 
  describe 'lat_lng' do 
    it "retrieves latitude and longitude given city and state", :vcr do 
      location= "denver, CO"
      parsed = MapquestService.lat_lng(location)
      parsed_location = parsed[:results].first[:locations].first

      expect(parsed).to be_a(Hash)      
      expect(parsed_location).to have_key(:latLng)
    end
  end

  describe "directions" do 
    it "retrieve driving directions from city a to city b", :vcr do 
      from = 'denver, co'
      to = 'arvada, co'
      parsed = MapquestService.directions(from, to)
      expect(parsed).to have_key(:route)
      expect(parsed[:route]).to have_key(:distance)
      expect(parsed[:route]).to have_key(:formattedTime)
      expect(parsed[:route]).to have_key(:realTime)
    end
  end
end