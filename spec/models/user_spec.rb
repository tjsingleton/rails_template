require 'spec_helper'

describe User do
  before(:each) do
    @valid_attributes = {
      :password => "password",
      :password_confirmation => "password",
      :email => "user@example.com"
    }
  end

  it "should create a new instance given valid attributes" do
    User.create!(@valid_attributes)
  end

  describe "should destroy the users unless she has no related assets" do
    before(:each) do
      @user = Factory(:user)
    end

    it "should not destroy the current user" do
      login
      @current_user.destroy.should be_false
      lambda { @current_user.reload }.should_not raise_error(ActiveRecord::RecordNotFound)
    end

    it "should destroy the user" do
      @user.destroy.should be_true
      lambda { @user.reload }.should raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
