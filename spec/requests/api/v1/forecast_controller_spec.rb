require 'rails_helper'

describe "forecast controller" do
  describe "index" do
    describe "happy path", :vcr do 
      it 'renders a json response with weather forecast given location params' do 
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

        expect(data[:attributes][:current_weather]).to have_key(:dt)
        expect(data[:attributes][:current_weather]).to have_key(:sunrise)
        expect(data[:attributes][:current_weather]).to have_key(:sunset)
        expect(data[:attributes][:current_weather]).to have_key(:temp)
        expect(data[:attributes][:current_weather]).to have_key(:feels_like)
        expect(data[:attributes][:current_weather]).to have_key(:humidity)
        expect(data[:attributes][:current_weather]).to have_key(:uvi)
        expect(data[:attributes][:current_weather]).to have_key(:visibility)
        expect(data[:attributes][:current_weather]).to have_key(:conditions)
        expect(data[:attributes][:current_weather]).to have_key(:icon)

        expect(data[:attributes][:current_weather]).to_not have_key(:pressure)
        expect(data[:attributes][:current_weather]).to_not have_key(:dew_point)
        expect(data[:attributes][:current_weather]).to_not have_key(:clouds)
        expect(data[:attributes][:current_weather]).to_not have_key(:wind_speed)
        expect(data[:attributes][:current_weather]).to_not have_key(:wind_deg)

        expect(data[:attributes][:hourly_weather].count).to eq(8)
        data[:attributes][:hourly_weather].each do |hourly|
          expect(hourly).to have_key(:time)
          expect(hourly).to have_key(:temp)
          expect(hourly).to have_key(:conditions)
          expect(hourly).to have_key(:icon)

          expect(hourly).to_not have_key(:wind_speed)
          expect(hourly).to_not have_key(:wind_deg)
        end

        expect(data[:attributes][:daily_weather].count).to eq(5)
        data[:attributes][:daily_weather].each do |daily|
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

      it "can accept json payload when query params are not passed" do 
        params = {"location": 'denver, CO'}
        headers = {'Content-type' => 'application/json', "HTTP_ACCEPT" => 'application/json'}
        get '/api/v1/forecast', headers: headers, params: params

        expect(response.status).to eq(200)
        
        parsed = JSON.parse(response.body, symbolize_names: true)
        
        expect(parsed).to have_key(:data)

        data = parsed[:data]
        expect(data).to have_key(:id)
        expect(data).to have_key(:type)
        expect(data).to have_key(:attributes)

        expect(data[:id]).to be_nil
        expect(data[:type]).to eq('forecast')
      end
    end

    describe "sad path", :vcr do 
      it "will error if location is not passed" do 
        params = {"location": ""}
        headers = {'Content-type' => 'application/json', "HTTP_ACCEPT" => 'application/json'}
        get '/api/v1/forecast', headers: headers, params: params

        expect(response.status).to eq(400)
      end

      # it "will error if location is gibberish" do 
      #   params = {"location": "afeadgafgsfaeff"}
      #   headers = {'Content-type' => 'application/json', "HTTP_ACCEPT" => 'application/json'}
      #   get '/api/v1/forecast', headers: headers, params: params
      #   binding.pry
      #   expect(response.status).to eq(400)
      # end
    end
  end
end
