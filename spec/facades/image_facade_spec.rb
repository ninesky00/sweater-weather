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
                                        username: 'xdesro',
                                        image_url: "https://images.unsplash.com/photo-1507070989769-45210775a437?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MXwyMTMwNjF8MHwxfHNlYXJjaHwxfHxkZW52ZXIsJTIwY29sb3JhZG98ZW58MHx8fA&ixlib=rb-1.2.1&q=80&w=1080")
    end
  end
end
