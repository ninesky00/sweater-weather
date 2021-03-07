require 'rails_helper'

describe OpenWeatherService do 
  describe 'forecast' do 
    it "retrieves current, hourly, and daily weather given lat and lon", :vcr do 
      latlng = {lat: 39.74, lng: -104.98}
      parsed = OpenWeatherService.forecast(latlng)
      
      expect(parsed).to have_key(:current)
      expect(parsed).to have_key(:hourly)
      expect(parsed).to have_key(:daily)

      expect(parsed).to have_key(:lat)
      expect(parsed).to have_key(:lon)
      expect(parsed).to have_key(:timezone)
      expect(parsed).to have_key(:timezone_offset)

      expect(parsed[:current]).to have_key(:dt)
      expect(parsed[:current]).to have_key(:sunrise)
      expect(parsed[:current]).to have_key(:sunset)
      expect(parsed[:current]).to have_key(:temp)
      expect(parsed[:current]).to have_key(:feels_like)
      expect(parsed[:current]).to have_key(:humidity)
      expect(parsed[:current]).to have_key(:uvi)
      expect(parsed[:current]).to have_key(:visibility)
      expect(parsed[:current][:weather].first).to have_key(:description)
      expect(parsed[:current][:weather].first).to have_key(:icon)

      expect(parsed[:hourly].count).to eq(48)
      parsed[:hourly].each do |hourly|
        expect(hourly).to have_key(:dt)
        expect(hourly).to have_key(:temp)
        expect(hourly[:weather].first).to have_key(:description)
        expect(hourly[:weather].first).to have_key(:icon)
      end

      expect(parsed[:daily].count).to eq(8)
      parsed[:daily].each do |daily|
        expect(daily).to have_key(:dt)
        expect(daily).to have_key(:sunrise)
        expect(daily).to have_key(:sunset)
        expect(daily).to have_key(:temp)
        expect(daily[:temp]).to have_key(:max)
        expect(daily[:temp]).to have_key(:min)
        expect(daily[:weather].first).to have_key(:description)
        expect(daily[:weather].first).to have_key(:icon)
      end
    end
  end
end