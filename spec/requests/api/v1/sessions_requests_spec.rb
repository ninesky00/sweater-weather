require 'rails_helper'

describe "sessions controller" do
  describe "create" do
    it "allows the user to login with correct credentials" do 
      user = User.create(email: 'test4@gmail.com', password: 'test4', password_confirmation: 'test4')
      user_params = {email: 'test4@gmail.com', password: 'test4'}
      headers = { 'Content-Type' => 'application/json'}

      post '/api/v1/sessions', headers: headers, params: JSON.generate({user: user_params})

      expect(response.status).to eq(200)
      expect(session[:user_id]).to eq(user.id)
      parsed = JSON.parse(response.body, symbolize_names: true)

      expect(parsed).to have_key(:status)
      expect(parsed).to have_key(:logged_in)
      expect(parsed).to have_key(:body)
      expect(parsed[:status]).to eq(200)
      expect(parsed[:body]).to have_key(:data)
      expect(parsed[:body][:data]).to have_key(:id)
      expect(parsed[:body][:data]).to have_key(:type)
      expect(parsed[:body][:data][:type]).to eq('user')
      expect(parsed[:body][:data]).to have_key(:attributes)
      expect(parsed[:body][:data][:attributes]).to have_key(:email)
      expect(parsed[:body][:data][:attributes]).to have_key(:auth_token)
    end
  end
end