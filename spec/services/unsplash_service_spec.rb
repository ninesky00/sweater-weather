require 'rails_helper'

describe UnsplashService do 
  describe 'search_image' do 
    it "retrieves an image based on query", :vcr do 
      query = "denver, colorado"
      parsed = UnsplashService.search_image(query)
      
      expect(parsed).to be_a(Hash)      
      expect(parsed).to have_key(:results)
      expect(parsed[:results].first).to have_key(:tags)
      expect(parsed[:results].first[:tags].first).to have_key(:title)
      expect(parsed[:results].first).to have_key(:description)
      expect(parsed[:results].first).to have_key(:alt_description)
      expect(parsed[:results].first).to have_key(:urls)
      expect(parsed[:results].first).to have_key(:user)
      expect(parsed[:results].first[:user]).to have_key(:username)
    end
  end
end