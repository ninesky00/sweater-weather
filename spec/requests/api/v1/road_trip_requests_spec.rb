require 'rails_helper'

describe "Road Trip requests" do
  describe "create" do 
    it "returns a road trip json object if post start, to, and api key", :vcr do
      user = User.create!(email: "test5@gmail.com", password: "test5", password_confirmation: "test5")
      params = {"origin": "Denver, CO", "destination": "Pueblo, CO", "api_key": "#{user.auth_token}"}
      headers = { 'Content-Type' => 'application/json'}
      post '/api/v1/road_trip', headers: headers, params: JSON.generate(params)
      expect(response.status).to eq(200)

      parsed = JSON.parse(response.body, symbolize_names:true)
      expect(parsed).to have_key(:data)
      expect(parsed[:data]).to have_key(:id)
      expect(parsed[:data][:id]).to be_nil
      expect(parsed[:data]).to have_key(:type)
      expect(parsed[:data][:type]).to eq('road_trip')
      expect(parsed[:data]).to have_key(:attributes)
      expect(parsed[:data][:attributes]).to have_key(:start_city)
      expect(parsed[:data][:attributes]).to have_key(:end_city)
      expect(parsed[:data][:attributes]).to have_key(:travel_time)
      expect(parsed[:data][:attributes]).to have_key(:weather_at_eta)
      expect(parsed[:data][:attributes][:weather_at_eta]).to have_key(:temp)
      expect(parsed[:data][:attributes][:weather_at_eta]).to have_key(:conditions)
    end
  end

  describe "sad path" do 
    it "errors I'm a teapot if key is not passed" do 
      params = {"origin": "Denver, CO", "destination": "Pueblo, CO", "api_key": ""}
      headers = { 'Content-Type' => 'application/json'}
      post '/api/v1/road_trip', headers: headers, params: JSON.generate(params)
      
      expect(response.status).to eq(418)
    end

    it "errors I'm a teapot if origin is not passed" do 
      user = User.create!(email: "test5@gmail.com", password: "test5", password_confirmation: "test5")
      params = {"origin": "", "destination": "Pueblo, CO", "api_key": "#{user.auth_token}"}
      headers = { 'Content-Type' => 'application/json'}
      post '/api/v1/road_trip', headers: headers, params: JSON.generate(params)
      
      expect(response.status).to eq(418)
    end

    it "errors 401 if key is incorrect" do 
      user = User.create!(email: "test5@gmail.com", password: "test5", password_confirmation: "test5")
      params = {"origin": "Denver, CO", "destination": "Pueblo, CO", "api_key": "gibberish"}
      headers = { 'Content-Type' => 'application/json'}
      post '/api/v1/road_trip', headers: headers, params: JSON.generate(params)
      
      expect(response.status).to eq(401)
    end
  end
end
