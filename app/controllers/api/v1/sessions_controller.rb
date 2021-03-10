class Api::V1::SessionsController < ApplicationController
  wrap_parameters :user, include: [:email, :password]
  
  def create
    user = User.find_by(email: params[:user][:email])
              .try(:authenticate, params[:user][:password])
    if user
      session[:user_id] = user.id
      render json: { status: 200, logged_in: true, body: UserSerializer.new(user) }, status: 200
    else
      render json: { status: 401, message: 'bad credentials'}, status: 401
    end
  end
end
