class Admin::UsersController < ApplicationController
  filter_access_to :all, :require => :read

  def index
    @users = User.paginate :page => params[:page], :order => 'updated_at DESC'
  end

  def update
    if user.update_attributes(params[:user])
      flash[:notice] = 'Successfully updated user.'
    else
      flash[:error] = 'Failed to update user.'
    end
    redirect_to admin_users_path
  end

  def destroy
    if user.destroy
      flash[:notice] = 'Successfully deleted user.'
    else
      flash[:error] = 'Failed to delete user.'
    end
    redirect_to admin_users_path
  end

  def user
    @user ||= User.find(params[:id])
  end
end