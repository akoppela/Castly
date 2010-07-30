class CreateVideos < ActiveRecord::Migration
  def self.up
    create_table :videos do |t|
      t.string      :title, :null => false
      t.integer     :length, :default => 0, :null => false #in minutes
      t.integer     :parent_id, :default => 0, :null => false
      t.integer     :season, :default => 0, :null => false
      t.integer     :episode, :default => 1, :null => false
      t.string      :file_file_name
      t.string      :file_content_type
      t.integer     :file_file_size
      t.timestamps
    end
  end

  def self.down
    drop_table :videos
  end
end
