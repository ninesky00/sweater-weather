class MunchieFacade
  class << self 
    def munchies
      parsed = YelpService.serach_business(destination, term, time)
    end
  end
end