class Admin::UsersController < ApplicationController
  filter_access_to :all, :require => :read
  
  def index
    @users = User.paginate :page => params[:page], :order => 'updated_at DESC'
  end
end