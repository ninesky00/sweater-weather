require 'rails_helper'

describe RoadtripFacade do 
  describe "travel_time" do
    it "retrieves real travel time from city a to city b", :vcr do 
      from = 'denver, co'
      to = 'boulder, co'
      parsed = RoadtripFacade.travel_time(from, to)
      expect(parsed).to be_a(Numeric)
    end

    it "retrieves formatted time from city a to city b if real time is 10000000", :vcr do 
      from = 'denver, co'
      to = 'arvada, co'
      parsed = RoadtripFacade.travel_time(from, to)
      expect(parsed).to be_a(Numeric)
    end
  end

  describe "arrival_forecast" do 
    it "outputs forecast at a future time", :vcr do 
      from = "denver, co"
      to = 'new york city, ny'
      parsed = RoadtripFacade.arrival_forecast(from, to)

      expect(parsed).to have_key(:temp)
      expect(parsed).to have_key(:conditions)
    end

    it "can deal with routes that take longer than 48 hours", :vcr do 
      from = "seattle, wa"
      to = "maine"
      
      parsed = RoadtripFacade.arrival_forecast(from, to)
      
      expect(parsed).to have_key(:max_temp)
      expect(parsed).to have_key(:min_temp)
      expect(parsed).to have_key(:conditions)
    end

    it "can deal with routes that are impossible", :vcr do 
      from = "new york , ny"
      to = "london, uk"

      parsed = RoadtripFacade.arrival_forecast(from, to)
      expect(parsed).to eq("Invalid location")
    end
  end
end