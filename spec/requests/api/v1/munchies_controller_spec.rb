require 'rails_helper'

describe "munchies controller" do
  describe "index" do
    describe "happy path", :vcr do 
      it 'renders a json response with details given params' do 
        get '/api/v1/munchies?start=denver,co&destination=pueblo,co&food=hamburger'
        expect(response.status).to eq(200)

        parsed = JSON.parse(response.body, symbolize_names: true)
        expect(parsed).to have_key(:data)

        data = parsed[:data]
        expect(data).to have_key(:id)
        expect(data).to have_key(:type)
        expect(data).to have_key(:attributes)

        expect(data[:id]).to be_nil
        expect(data[:type]).to eq('munchie')

        expect(data[:attributes]).to have_key(:destination_city)
        expect(data[:attributes]).to have_key(:travel_time)
        expect(data[:attributes]).to have_key(:forecast)
        expect(data[:attributes][:forecast]).to have_key(:summary)
        expect(data[:attributes][:forecast]).to have_key(:temperature)
        expect(data[:attributes]).to have_key(:restaurant)
        expect(data[:attributes][:restaurant]).to have_key(:name)
        expect(data[:attributes][:restaurant]).to have_key(:address)
      end
    end
  end
end