class ApplicationController < ActionController::API
  include ErrorHelper
  @current_user = nil # parse request and check username
end
