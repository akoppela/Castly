class UsersController < ApplicationController
  before_filter :authenticate, :except => [:new, :create]
  respond_to :html
  
  def new
    @user = User.new
    render :new, :layout => 'minimal'
  end
  
  def create
    @user = User.create(params[:user])
    respond_with @user, :location => root_path, :notice => "Registration successful!", :layout => "minimal"
  end
  
end
