class ApplicationController < ActionController::Base
  include AuthlogicControllerMethods

  protect_from_forgery
  layout 'application'
end
