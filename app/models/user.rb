class User < ActiveRecord::Base
  acts_as_authentic do |c|
    c.email_field :login
  end
  
  has_one  :invite, :class_name => "Invite", :foreign_key => "recipient_id"
  has_many :sent_invites, :class_name => "Invite", :foreign_key => "sender_id"
  
  has_many :downloads
  has_many :videos
  
  validates :invite_token, :presence => true
  
  def invite_token
    invite.token if invite
  end
  
  def invite_token=(v)
    invite = Invite.find_by_token(v)
  end
  
end
