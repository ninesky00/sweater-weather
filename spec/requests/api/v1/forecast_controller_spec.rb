require 'rails_helper'

describe "forecast controller" do
  describe "index" do
    it 'renders a json response with weather forecast given location params', :vcr do 
      params = {location: 'denver, CO'}
      get '/api/v1/forecast?location=denver,co'

      expect(response.status).to eq(200)
      
      parsed = JSON.parse(response.body, symbolize_names: true)
      
      expect(parsed).to have_key(:data)

      data = parsed[:data]
      expect(data).to have_key(:id)
      expect(data).to have_key(:type)
      expect(data).to have_key(:attributes)

      expect(data[:id]).to be_nil
      expect(data[:type]).to eq('forecast')

      expect(data[:attributes]).to have_key(:current_weather)
      expect(data[:attributes]).to have_key(:daily_weather)
      expect(data[:attributes]).to have_key(:hourly_weather)

      
      binding.pry
    end
  end
  
end
