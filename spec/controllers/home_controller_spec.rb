require File.dirname(__FILE__) + '/../spec_helper'

describe HomeController do
  it "should respond to /" do
    route_for(:controller => "home", :action => "index").should == "/"
  end

  it "should render index template" do
    get :index
    response.should render_template(:index)
  end

  it "should set @user_session member for login form" do
    get :index
    assigns[:user_session].should_not == nil
  end
end
