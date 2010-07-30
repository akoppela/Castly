class User < ActiveRecord::Base
  acts_as_authentic do |c|
    c.email_field :login
  end
  
  has_many :downloads
  has_many :videos
end
