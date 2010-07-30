class CreateVideos < ActiveRecord::Migration
  def self.up
    create_table :videos do |t|
      t.references  :user,       :null => false
      t.references  :video_file

      t.string      :title,     :null => false
      t.integer     :sec_length,    :default => 0, :null => false #in sec
      t.boolean     :serial,    :default => false
      
      t.integer     :parent_id
      
      t.integer     :episode_number, :default => 0
      t.references  :season
      
      t.integer     :sec_viewed, :default => 0, :null => false
      
      t.timestamps
    end
    add_index :videos, :user_id
  end

  def self.down
    drop_table :videos
  end
end