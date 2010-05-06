class PasswordResetsController < ApplicationController
  before_filter :require_no_user
  before_filter :load_user_using_perishable_token, :only => [:edit, :update]

  def new
    @email = params[:email]
  end

  def create
    if @user = User.find_by_email(params[:email])
      @user.reset_perishable_token!
      UserNotification.password_reset_email(@user).deliver
      flash[:notice] = "Instructions to reset your password have been emailed to you. Please check your email."
      redirect_to root_url
    else
      flash[:error] = "No user was found with that email address"
      render :action => :new
    end
  end

  def edit
  end

  def update
    @user.password, @user.password_confirmation = params[:user][:password], params[:user][:password_confirmation]
    if @user.save
      flash[:notice] = "Password successfully updated"
      redirect_to root_url
    else
      flash[:notice] = @user.errors.full_messages
      render :action => :edit
    end
  end

  private
  def load_user_using_perishable_token
    unless @user = User.find_using_perishable_token(params[:id])
      flash[:notice] = "We're sorry, but we could not locate your account. If you are having issues try copying and " +
                       "pasting the URL from your email into your browser or restarting the reset password process."
      redirect_to root_url
    end
  end
end