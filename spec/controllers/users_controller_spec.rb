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
      before(:each) do
        @email = "foo@bar.com"
        @password = "secret"
        @user = Factory.build(:user, :email => @email)
        User.stub!(:new).and_return(@user)
      end
      
      it "exposes a newly created user as @user and redirect to root page" do
        post :create, :user => { :email => @email, :password => @password, :password_confirmation => @password }
        assigns[:user].should == @user
        flash[:notice].should =~ /successful/
        response.should redirect_to(root_url)
      end
    end
    
    describe "with invalid params" do
      it "assigns a newly created but unsaved user as @user and renders [new] template" do
        @user = Factory.build(:user, :email => "")
        User.stub!(:new).and_return(@user)
        
        post :create, :user => {}
        assigns[:user].should == @user
        response.should render_template("users/new")
      end
    end
    
  end # </responding to POST create>
  
  describe "responding to GET edit" do
    before(:each) do
      login
      @user = @current_user
    end
    
    it "should expose current user as @user and render [edit] template" do
      post :edit, :id => @user.id
      assigns[:user].should == @current_user
      response.should render_template("users/edit")
    end
  end # </responding to GET edit>
  
  describe "responding to PUT udpate" do
    before(:each) do
      login
      @user = @current_user
    end
    
    describe "with valid params" do
      it "should update user information and render [edit] template" do
        post :update, :id => @user.id, :user => { :email => "foo@bar.com" }
        @user.reload.email.should == "foo@bar.com"
        assigns[:user].should == @user
        flash[:notice].should =~ /Successfully updated profile/
        response.should redirect_to(root_url)
      end
      
      it "should update user information and render [edit] template" do
        @current_user_session.stub!(:unauthorized_record=)
        @current_user_session.stub!(:save)
        post :update, :id => @user.id, :user => { :password => "asdk", :password_confirmation => "asdk" }
        @user.reload.password.should == "asdk"
        assigns[:user].should == @user
        flash[:notice].should =~ /Successfully updated profile/
        response.should redirect_to(root_url)
      end
    end
    
    describe "with invalid params" do
      it "should not update the user information and redraw [edit] template" do
        post :update, :id => @user.id, :user => { :email => "test@invalid.local" }
        @user.reload.email.should == @user.email
        assigns[:user].should == @user
        response.should render_template("users/edit")
      end
    end
  end # </responding to PUT update>

end
