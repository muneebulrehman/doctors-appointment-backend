class Api::UsersController < ApplicationController
  def create
    @user = User.new(user_params)
    if @user.save
      response.headers['Set-Cookie'] = "user_name=#{user_params[:user_name]}"
      render json: { success: true, message: 'User created successfully' }, status: :created
    else
      render json: { success: false, message: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def authenticate
    @user = User.where(user_name: params[:user_name])
    if @user.present?
      response.headers['Set-Cookie'] = "user_name=#{params[:user_name]}"
      render json: { success: true, message: 'User logged in successfully' }, status: :ok
    else
      render json: { success: false, message: 'User not found' }, status: :not_found
    end
  end

  # DOESNT FUCKING WORK
  # def logout
  #   de_authenticate_user
  #   render json: { success: true, message: 'User logged out successfully' }, status: :ok
  # end

  private

  def user_params
    params.require(:user).permit(:user_name, :email)
  end
end
