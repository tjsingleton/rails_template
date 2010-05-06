require 'spec_helper'

describe "Root view" do
  before(:each) do
    activate_authlogic
    assigns[:user_session] = UserSession.new
    render '/home/index', :layout => "application"
  end

end
