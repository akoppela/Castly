class Download < ActiveRecord::Base
  belongs_to :user
  
  before_save :check_type
  
  has_attached_file :file
  
  
  state_machine :initial => :created do
     after_transition :created => :downloading, :do => :notify_about_downloading
     after_transition :downloading => :transcoding, :do => :notify_about_downloading
     after_transition :transcoding => :finished, :do => :notify_about_downloading

     event :start do
       transition :created => :downloading
     end
     
     event :process do
       transition :created => :downloading, :downloading => :transcoding, :transcoding => :finished
    end

     state :created
     state :downloading
     state :transcoding
     state :finished
  end
  
  
  
end
