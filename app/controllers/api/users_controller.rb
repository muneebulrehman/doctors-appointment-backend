class Api::UsersController < ApplicationController
  def create
    @user = User.new(user_params)
    if @user.save
      @current_user = @user
      @logged_in = true
      render json: { success: true, message: 'User created successfully' }, status: :created
    else
      render json: { success: false, message: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def authenticate
    @user = User.where(user_name: params[:user_name])
    if @user.present?
      @current_user = @user
      @logged_in = true
      render json: { success: true, message: 'User logged in successfully' }, status: :ok
    else
      render json: { success: false, message: 'User not found' }, status: :not_found
    end
  end

  private

  def user_params
    params.require(:user).permit(:user_name, :email)
  end
end
