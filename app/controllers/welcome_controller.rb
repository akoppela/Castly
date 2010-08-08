class WelcomeController < ApplicationController
  
  def index
    #redirect_to videos_path if current_user
    render "prerelease"
  end
end
