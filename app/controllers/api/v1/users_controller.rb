class Api::V1::UsersController < ApplicationController
  wrap_parameters :user, include: [:email, :password, :password_confirmation]
  
  def create
    user = User.new(user_params)
    if user.save
      session[:user_id] = user.id
      render json: { status: :created, body: UserSerializer.new(user) }, status: 201
    else
      render json: { status: 409, message: user.errors}, status: 409
    end
  end

  private 

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end