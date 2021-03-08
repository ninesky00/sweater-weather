require 'rails_helper'

describe "backgrounds controller" do
  describe "index" do
    describe "happy path", :vcr do 
      it 'renders a json response with background image given location params' do 
        get '/api/v1/backgrounds?location=denver,colorado'
        
        expect(response.status).to eq(200)
        parsed = JSON.parse(response.body, symbolize_names: true)
        
        expect(parsed).to have_key(:data)

        data = parsed[:data]
        expect(data).to have_key(:id)
        expect(data).to have_key(:type)
        expect(data).to have_key(:attributes)

        expect(data[:id]).to be_nil
        expect(data[:type]).to eq('image')

        expect(data[:attributes]).to have_key(:image)
        expect(data[:attributes][:image]).to have_key(:location)
        expect(data[:attributes][:image]).to have_key(:image_url)
        expect(data[:attributes][:image]).to have_key(:description)
        expect(data[:attributes][:image]).to have_key(:credit)
        expect(data[:attributes][:image][:credit]).to have_key(:author)
        expect(data[:attributes][:image][:credit]).to have_key(:username)
      end
    end
  end
end