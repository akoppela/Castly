class InviteInquiriesController < ApplicationController
  
  def create
    @invite_inquiry = InviteInquiry.create(params[:invite_inquiry])
    if @invite_inquiry.valid?
      redirect_to root_path
    else
      render 'welcome/prerelease'
    end
  end
end
