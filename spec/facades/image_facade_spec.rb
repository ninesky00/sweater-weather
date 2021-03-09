require 'rails_helper'

describe ImageFacade do
  describe "search_image", :vcr do 
    it "returns image location, url, and credits" do 
      query = "denver, colorado"
      result = ImageFacade.search_image(query)

      expect(result).to be_an Image
      expect(result).to have_attributes(location: 'denver', 
                                        description: 'high-rise brown concrete building', 
                                        author: 'Henry Desro',
                                        username: 'xdesro')
    end
  end
end
