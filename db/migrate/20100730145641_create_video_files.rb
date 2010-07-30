class CreateVideoFiles < ActiveRecord::Migration
  def self.up
    create_table :video_files do |t|
      t.string      :file_file_name
      t.string      :file_content_type
      t.integer     :file_file_size
      t.timestamps
    end
  end

  def self.down
    drop_table :video_files
  end
end
