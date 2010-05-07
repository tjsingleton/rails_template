class AccountsController < ApplicationController
  before_filter :require_user
  before_filter :user

  def show

  end

  private
  def user
    @user ||= current_user
  end
end
