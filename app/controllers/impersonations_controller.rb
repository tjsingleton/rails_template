class ImpersonationsController < ApplicationController
  def new
    @users = User.where("id <> ?", current_user.id)
    if @users.empty?
      redirect_back_or_default root_url
      flash[:notice] = "No users to impersonate"
    end
  end

  def create
    user = User.find_by_id params[:user][:id]
    @current_user_session = UserSession.new
    @current_user_session.credentials = [user, false, :impersonation]
    @current_user_session.save
    redirect_to root_url
  end
end