require File.dirname(__FILE__) + '/../spec_helper'

describe UserSessionsController do
  before(:each) do
    activate_authlogic
    logout
  end

  describe "responding to GET new" do
    it "new action should render new template" do
      get :new
      response.should render_template(:new)
    end
  end

  describe "POST authentications" do
    before(:each) do
      @login = { :email => "foo@bar", :password => "pass", :remember_me => "0" }
      @user_session = mock_model(UserSession, @login)
    end

    describe "successful authentication" do
      before(:each) do
        @user_session.stub!(:save).and_return(true)
        UserSession.stub!(:new).and_return(@user_session)
      end

      it "displays welcome message and redirects to the home page" do
        @user = Factory(:user, :email => "foo@bar.com", :password => "pass", :password_confirmation => "pass", 
                        :login_count => 0)
        @user_session.stub!(:user).and_return(@user)

        post :create, :user_session => @login
        flash[:notice].should_not == nil
        flash[:notice].should_not =~ /last login/
        response.should redirect_to(account_profile_url)
      end

      it "displays last login time if it's not the first login" do
        @user = Factory(:user, :email => "foo@bar.com", :password => "pass", :password_confirmation => "pass",
                        :login_count => 42, :last_login_at => 1.hour.ago)
        @user_session.stub!(:user).and_return(@user)

        post :create, :user_session => @login
        flash[:notice].should =~ /last login/
        response.should redirect_to( account_profile_url)
      end
    end

    describe "authenticaion failure" do
      describe "user is not suspended" do
        it "redirects to login page if email or password are invalid" do
          @user = Factory(:user, :email => "foo@bar.com", :password => "pass", :password_confirmation => "pass")
          @user_session.stub!(:user).and_return(@user)
          @user_session.stub!(:save).and_return(false) # <--- Authentication failure.
          UserSession.stub!(:new).and_return(@user_session)

          post :create, :user_session => @login
          flash[:warning].should_not == nil
          response.should redirect_to(:action => :new)
        end
      end
    end # authentication failure
  end # POST authenticate

  describe "routing" do
    it "should go to 'user_sessions' controller and 'new' action for /login" do
      params_from(:get, "/login").should == {:controller => "user_sessions", :action => "new"}
    end

    it "should go to 'user_sessions' controller and 'destroy' action for /logout" do
      params_from(:get, "/logout").should == {:controller => "user_sessions", :action => "destroy"}
    end
  end

end
