class SessionsController < ApplicationController
  layout 'minimal'
  before_filter :authenticate, :only => :destroy
  before_filter :require_no_user, :except => :destroy
  
  respond_to :html
  
  def new
    @session = UserSession.new
  end

  def create
    @session = UserSession.create(params[:user_session])
    respond_with @session , :location => root_path, :notice => "Login successful!"
  end

  def destroy
    current_session.destroy
    redirect_to root_path
  end

end
