require 'rails_helper'

describe YelpService do 
  describe 'search_business' do 
    it "retrieves local businesses given city and state", :vcr do 
      destination = "pueblo,co"
      term = "hamburger"
      time = DateTime.new(2021,03,8,14).to_i
      parsed = YelpService.search_business(destination, term, time)

      expect(parsed).to have_key(:businesses)
      expect(parsed[:businesses].first).to have_key(:name)
      expect(parsed[:businesses].first).to have_key(:location)
      expect(parsed[:businesses].first[:location]).to have_key(:display_address)
    end
  end
end