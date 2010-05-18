class Admin::UsersController < ApplicationController
  def index
    @users = User.paginate :page => params[:page], :order => 'updated_at DESC'
  end
end