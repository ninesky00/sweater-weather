class ImageFacade
  class << self 
    def search_image(query)
      parsed = UnsplashService.search_image(query)
      Image.new(parsed)
    end
  end
end