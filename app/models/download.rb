class Download < ActiveRecord::Base
  belongs_to :user

  validates :user, :presence => true

  after_create :job_process

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
  
  private
    def job_process
      job_type = torrent ? "TorrentDownload" : "FileDownload"
      Jobling::Processor.enqueue job_type, id
    end
end
