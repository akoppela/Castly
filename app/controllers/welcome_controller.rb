class WelcomeController < ApplicationController
  layout 'minimal'
  def index
    redirect_to videos_paths if current_user
    # render "prerelease", :layout => "minimal"
  end
end
