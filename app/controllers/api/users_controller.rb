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
      render json: { success: true, message: 'User logged in successfully' }, status: :ok
    else
      render json: { success: false, message: 'User not found' }, status: :not_found
    end
  end

  # def update
  #   if @user.update(user_params)
  #     render json: { success: true, message: 'User updated successfully' }, status: :ok
  #   else
  #     render json: { success: false, message: @user.errors.full_messages }, status: :unprocessable_entity
  #   end
  # end

  # def destroy
  #   @user.destroy
  #   render json: { success: true, message: 'User deleted successfully' }, status: :ok
  # end

  private

  def user_params
    params.require(:user).permit(:user_name, :email)
  end
end
