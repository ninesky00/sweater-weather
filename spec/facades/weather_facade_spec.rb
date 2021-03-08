require 'rails_helper'

describe WeatherFacade do 
  describe 'lat_lng' do 
    it "converts city and state location into latitude and longitude" do 
      VCR.use_cassette('retrieves_latitude_and_longitude_given_city_and_state.yml') do 
        location = 'denver, CO'
        lat_lng = WeatherFacade.lat_lng(location)
        expect(lat_lng.keys.count).to eq(2)
        expect(lat_lng).to have_key(:lat)
        expect(lat_lng).to have_key(:lng)
      end
    end
  end

  describe 'weather' do 
    it 'creates forecast object from open weather forecast', :vcr do 
      location = 'denver, CO'
      result = WeatherFacade.weather(location)

      expect(result).to be_a(Forecast)
      expect(result.current_weather).to be_a(Hash)
      expect(result.daily_weather).to be_a(Array)
      expect(result.hourly_weather).to be_a(Array)

      expect(result.current_weather).to have_key(:dt)
      expect(result.current_weather).to have_key(:sunrise)
      expect(result.current_weather).to have_key(:sunset)
      expect(result.current_weather).to have_key(:temp)
      expect(result.current_weather).to have_key(:feels_like)
      expect(result.current_weather).to have_key(:humidity)
      expect(result.current_weather).to have_key(:uvi)
      expect(result.current_weather).to have_key(:visibility)
      expect(result.current_weather).to have_key(:conditions)
      expect(result.current_weather).to have_key(:icon)

      expect(result.current_weather).to_not have_key(:pressure)
      expect(result.current_weather).to_not have_key(:dew_point)
      expect(result.current_weather).to_not have_key(:clouds)
      expect(result.current_weather).to_not have_key(:wind_speed)
      expect(result.current_weather).to_not have_key(:wind_deg)

      expect(result.hourly_weather.count).to eq(8)
      result.hourly_weather.each do |hourly|
        expect(hourly).to have_key(:time)
        expect(hourly).to have_key(:temp)
        expect(hourly).to have_key(:conditions)
        expect(hourly).to have_key(:icon)

        expect(hourly).to_not have_key(:wind_speed)
        expect(hourly).to_not have_key(:wind_deg)
      end

      expect(result.daily_weather.count).to eq(5)
      result.daily_weather.each do |daily|
        expect(daily).to have_key(:dt)
        expect(daily).to have_key(:sunrise)
        expect(daily).to have_key(:sunset)
        expect(daily).to have_key(:max_temp)
        expect(daily).to have_key(:min_temp)
        expect(daily).to have_key(:conditions)
        expect(daily).to have_key(:icon)
        expect(daily).to_not have_key(:wind_speed)
        expect(daily).to_not have_key(:wind_deg)
      end
    end
  end
end