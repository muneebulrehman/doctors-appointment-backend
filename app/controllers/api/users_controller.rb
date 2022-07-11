class Api::UsersController < ApplicationController

  def create
    @user = User.new(user_params)
    if @user.save
      render json: { success: true, message: 'User created successfully' }, status: :created
    else
      render json: { success: false, message: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def login
    @user = User.where(user_name: params[:user_name])
    if @user.present?
      set_current_user(params[:user_name])
      render json: { success: true, message: 'User logged in successfully' }, status: :ok
    else
      render json: { success: false, message: 'User not found' }, status: :not_found
    end
  end

  def logout
    destroy_current_user
    render json: { success: true, message: 'User logged out successfully' }, status: :ok
  end

  private

  def user_params
    params.require(:user).permit(:user_name, :email)
  end
end
