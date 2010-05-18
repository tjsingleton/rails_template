class AccountsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      UserNotification.new_account_email(@user).deliver
      flash[:notice] = 'Registration successful.'
      redirect_to root_url
    else
      render :action => 'new'
    end
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update_attributes(params[:user])
      flash[:notice] = 'Successfully updated profile.'
      redirect_back_or_default root_url
    else
      render :action => 'edit'
    end
  end
end
