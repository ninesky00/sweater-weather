class ImageFacade
  class << self 
    def search_image(query)
      Image.new(UnsplashService.search_image(query))
    end
  end
end