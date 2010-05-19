require "spec_helper"

describe User::Role do
  let(:user) { Factory.build(:user, :role_mask => 6) }

  context "#lookup_role_value" do
    it "accepts a symbol" do
      user.send(:lookup_role_value, :admin).should == User::ROLES[:admin]
    end

    it "accepts a string" do
      user.send(:lookup_role_value, 'admin').should == User::ROLES[:admin]
    end

    it "accepts a integer" do
      user.send(:lookup_role_value, 8).should == 8
    end

    it "raises on 0" do
      lambda { user.send(:lookup_role_value, 0) }.should raise_error(ArgumentError)
    end

    it "raises on nil" do
      lambda { user.send(:lookup_role_value, nil) }.should raise_error(ArgumentError)
    end
  end

  context "#has_role?" do
    it "doesn't have guest role" do
      user.has_role?(:guest).should be_false
    end

    it "has a user role" do
      user.has_role?(:user).should be_true
    end

    it "has a manger role" do
      user.has_role?(:manager).should be_true
    end

    it "doesn't have admin role" do
      user.has_role?(:admin).should be_false
    end
  end

  it "#role_symbols returns an array of symbols" do
    user.role_symbols.should == [:user, :manager]
  end

  context "#add_role" do
    before do
      user.add_role(:admin)
    end

    it "adds the role admin" do
      user.has_role?(:admin).should be_true
    end

    it "increases the role_mask by admin's value" do
      user.role_mask.should == User::ROLES[:user] + User::ROLES[:manager] + User::ROLES[:admin]
    end
  end

  context "#remove_role" do
    before do
      user.remove_role(:manager)
    end

    it "removes the role manager" do
      user.has_role?(:manager).should be_false
    end

    it "decreases the role_mask by the manager's value" do
      user.role_mask.should == User::ROLES[:user]
    end
  end

  it "#replace_roles sets the roles to admin" do
    user.replace_roles([:admin]).role_symbols.should == [:admin]
  end
end