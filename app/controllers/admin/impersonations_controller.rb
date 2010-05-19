class Admin::ImpersonationsController < ApplicationController
  filter_access_to :all, :require => :read

  def new
    @users = User.where("id <> ?", current_user.id)
    if @users.empty?
      redirect_back_or_default root_url
      flash[:notice] = "No users to impersonate"
    end
  end

  def create
    user_id = params[:user] && params[:user][:id]
    if user_id && user = User.find(user_id)
      @current_user_session = UserSession.new
      @current_user_session.credentials = [user, false, :impersonation]
      @current_user_session.save
      redirect_to root_url
    else
      flash[:error] = "Could not find user to impersonate."
      redirect_to root_url
    end
  end
end