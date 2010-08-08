class CreateJobs < ActiveRecord::Migration
  def self.up
    create_table :jobs do |t|
      t.integer  :priority, :default => 0    
      t.integer  :attempts, :default => 0
          
      t.text     :encoded_processor
      t.string   :queue

      t.string   :last_error
      
      t.timestamp :locked_at                    
      t.timestamp :processed_at
      t.timestamp :failed_at
      
      t.string   :locked_by  #HOST_NAME:WORKER_NAME:WORKER_HASH unique for all jobs
      t.timestamps
    end
  end

  def self.down
    drop_table :jobs
  end
end
