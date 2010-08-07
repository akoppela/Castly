class VideosController < ApplicationController
  before_filter :authenticate, :find_video
  
  def index
    @videos = current_user.videos
  end
  
  
  def show
  
  end
  
  protected
    
    def find_video
      @video = Video.find(params[:id]) if params[:id]
    end
end
