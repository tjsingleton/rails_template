class ApplicationController < ActionController::Base
  helper_method :current_user_session, :current_user
  include AuthlogicControllerMethods

  protect_from_forgery
  layout 'application'

  before_filter :set_current_user

  protected
  ##
  # Establish current user for declarative authorization
  def set_current_user
    Authorization.current_user = current_user
  end
end
