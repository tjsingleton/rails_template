class ApplicationController < ActionController::Base
  helper_method :current_user_session, :current_user
  include AuthlogicControllerMethods

  protect_from_forgery
  layout 'application'
end
