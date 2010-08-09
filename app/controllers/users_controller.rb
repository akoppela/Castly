class UsersController < ApplicationController
  before_filter :authenticate, :except => [:new, :create]
  respond_to :html
  layout 'minimal'
  
  def new
    @user = User.new
    render :new
  end
  
  def create
    @user = User.create(params[:user])
    respond_with @user, :location => root_path, :notice => "Registration successful!"
  end
  
end
