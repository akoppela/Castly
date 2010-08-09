class WelcomeController < ApplicationController
  layout 'minimal'
  def index
    redirect_to videos_path if current_user
    # render "prerelease", :layout => "minimal"
  end
end
