class DownloadsController < ApplicationController
  before_filter :authenticate, :find_download
  
  respond_to :html
  
  def index
    @downloads = current_user.downloads.all
  end
  
  
  def new
    @download = Download.new
  end
  
  def create
    @download = current_user.downloads.create(params[:download])
    respond_with @download, :location => downloads_path, :notice => "Please wait, your download will be processed"
  end
  
  def destroy
    @download.destroy
    redirect_to downloads_path
  end
  
  protected
    def find_download
      @download = Download.find(params[:id]) if params[:id]
    end
end
