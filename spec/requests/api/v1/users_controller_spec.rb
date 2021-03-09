require 'rails_helper'

describe "users controller" do
  describe "create" do
    it "creates a user given proper params" do 
      user_params = {email: 'person@woohoo.com', password: 'abc123', 
                    password_confirmation: 'abc123'}
      headers = { 'Content-Type' => 'application/json'}

      post '/api/v1/users', headers: headers, params: JSON.generate({user: user_params})
      expect(response.status).to eq(201)
      
      created_user = User.last
      expect(created_user.email).to eq(user_params[:email])

      parsed = JSON.parse(response.body, symbolize_names: true)

      expect(parsed).to have_key(:status)
      expect(parsed).to have_key(:body)
      expect(parsed[:status]).to eq('created')
      expect(parsed[:body]).to have_key(:data)
      expect(parsed[:body][:data]).to have_key(:id)
      expect(parsed[:body][:data]).to have_key(:type)
      expect(parsed[:body][:data][:type]).to eq('user')
      expect(parsed[:body][:data]).to have_key(:attributes)
      expect(parsed[:body][:data][:attributes]).to have_key(:email)
      expect(parsed[:body][:data][:attributes]).to have_key(:auth_token)
    end
  end

  # describe "sad happy" do
  #   it "dot not create user when already created" do 
  #     user_params = {email: 'person@woohoo.com', password: 'abc123', 
  #                   password_confirmation: 'abc123'}
  #     headers = { 'Content-Type' => 'application/json'}

  #     post '/api/v1/users', headers: headers, params: JSON.generate({user: user_params})

  #     post '/api/v1/users', headers: headers, params: JSON.generate({user: user_params})
  #     expect(response.status).to eq(409)
  #   end
  # end
end