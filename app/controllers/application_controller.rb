class ApplicationController < ActionController::API
  include ErrorHelper
  include SuccessHelper
  @current_user = nil # parse request and check username

  def authenticate_user
    cookie = request.headers['Cookie']
    cookie_list = cookie&.split(';')
    user_name_cookie = cookie_list&.select { |co| co.include?('user_name') }

    return unless user_name_cookie.length.positive?

    user_name_cookie_splitted = user_name_cookie[0].split('=')
    return unless user_name_cookie_splitted.length

    @current_user = user_name_cookie_splitted[1]
  end

  def request_user_id
    return unless @current_user

    User.where({ user_name: @current_user })[0]&.id
  end
end
