class Admin::UsersController < ApplicationController
  filter_access_to :all, :require => :read

  def index
    @users = User.paginate :page => params[:page], :order => 'updated_at DESC'
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:notice] = 'Successfully updated user.'
      redirect_to admin_users_path
    else
      flash[:error] = 'Failed to update user.'
      render :action => 'edit'
    end
  end
end