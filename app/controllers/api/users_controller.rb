class Api::UsersController < ApplicationController
  def create
    @user = User.new(user_params)
    if @user.save
      render json: { success: true, message: 'User created successfully' }, status: :created
    else
      render json: { success: false, message: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def authenticate
    response.headers['Set-Cookie'] = "user_name=#{params[:user_name]}"
    @user = User.where(user_name: params[:user_name])
    if @user.present?   
      render json: { success: true, message: 'User logged in successfully' }, status: :ok
    else
      render json: { success: false, message: 'User not found' }, status: :not_found
    end
  end

  # def logout
  #   @current_user = nil
  #   @logged_in = false
  #   render json: { success: true, message: 'User logged out successfully' }, status: :ok
  # end

  private

  def user_params
    params.require(:user).permit(:user_name, :email)
  end
end
