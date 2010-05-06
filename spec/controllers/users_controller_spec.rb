require File.dirname(__FILE__) + '/../spec_helper'

describe UsersController do

  describe "responding to GET new" do
    it "new action should rend er new template" do
      get :new
      response.should render_template(:new)
    end
  end

  describe "responding to POST create" do

    describe "with valid params" do
      it "exposes a newly created user as @user and redirect to hotspots account page if reg as supplier" do
          @username = "none"
          @email = @username + "@example.com"
          @password = "secret"
          @user = Factory.build(:user, :username => @username, :email => @email)
          @params = Factory.attributes_for(:user)
          User.stub!(:new).and_return(@user)
        post :create, { :agreebox=>true, :user=>@params}
        assigns[:user].should == @user
        assigns[:user].should_not be_new_record
        flash[:notice].should =~ /successful/
        response.should redirect_to(account_my_hotspots_path)
      end
    end
    describe "with valid params1" do
      it "exposes a newly created user as @user and redirect to profile account page if reg as not supplier" do
        post :create, { :agreebox=>true, :user => {:username=>'test',:email=>'test@m.ru',:password=>'passw',:password_confirmation=>'passw',:phone=>'22222'}}
        assigns[:user].should_not be_new_record
        flash[:notice].should =~ /successful/
        response.should redirect_to(account_profile_path)
      end
    end

    describe "with invalid params" do
      
      it "assigns a newly created but unsaved user as @user and renders [new] template if not agrred with aggreement" do
        post :create, { :user => { :username => @username, :email => @email, :password => @password, :password_confirmation => @password, :is_supplier=>true, :is_subscriber=>true }}
        assigns[:user].should be_new_record
        flash[:warning].should =~ /confirm the agreement/
        response.should render_template("users/new")
      end
      it "assigns a newly created but unsaved user as @user and renders [new] template" do
        @user = Factory.build(:user, :username => "", :email => "")
        User.stub!(:new).and_return(@user)

        post :create, :user => {}
        assigns[:user].should == @user
        assigns[:user].should be_new_record
        response.should render_template("users/new")
      end
    end

  end

  

end
