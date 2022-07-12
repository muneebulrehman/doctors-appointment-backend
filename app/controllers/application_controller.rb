class ApplicationController < ActionController::API
  include ErrorHelper
  @current_user = nil # parse request and check username

  def authenticate_user
    cookie = request.headers['Cookie']
    cookie_list = cookie&.split(';')
    user_name_cookie = cookie_list&.select { |co| co.include?('user_name') }
    if user_name_cookie
      _user_name_cookies = user_name_cookie[0]&.split('=')
      @current_user = _user_name_cookies[1] if _user_name_cookies
    end
  end
end
