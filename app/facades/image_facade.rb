class ImageFacade
  class << self 
    def search_image(query)
      parsed = UnsplashService.search_image(query)
    end
  end
end