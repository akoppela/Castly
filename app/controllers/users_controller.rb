class UsersController < ApplicationController
  before_filter :authenticate
  respond_to :html
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.create(params[:user])
    respond_with @user, :location => root_path, :notice => "Registration successful!"
  end
  
end
