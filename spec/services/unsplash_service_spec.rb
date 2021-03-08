require 'rails_helper'

describe UnsplashService do 
  describe 'search_image' do 
    it "retrieves an image based on query", :vcr do 
      query = "denver"
      parsed = UnsplashService.search_image(query)
      binding.pry 

      expect(parsed).to be_a(Hash)      
      expect(parsed_location).to have_key(:latLng)
    end
  end
end