class HomeController < ApplicationController
  def index
    render json: { message: 'Welcome to the API' }
  end

  def logout
    de_authenticate_user
    render json: { success: true, message: 'User logged out successfully' }, status: :ok
  end
end
