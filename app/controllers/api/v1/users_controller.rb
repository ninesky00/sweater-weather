class Api::V1::UsersController < ApplicationController
  def create
    user = User.create!(email: params['user']['email'], 
                        password: params['user']['password'],
                        password_confirmation: params['user']['password_confirmation'])
    if user
      session[:user_id] = user.id
      render json: { status: :created, body: UserSerializer.new(user) }, status: 201
    else
      render json: { status: 409, message: user.errors}
    end
  end
end