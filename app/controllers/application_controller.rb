class ApplicationController < ActionController::API
  # helper_method :current_user
  @@CURRENT_USER
  @@logged_in = false
  def set_current_user(user)
    @@CURRENT_USER = User.where(user_name: user)
    @@logged_in = true
  end

  def destroy_current_user
    @@CURRENT_USER = nil
    @@logged_in = false
  end
end
