class CreateDownloads < ActiveRecord::Migration
  def self.up
    create_table :downloads do |t|
      t.references :user, :null => false
      t.string      :file_file_name
      t.string      :file_content_type
      t.integer     :file_file_size
      t.timestamps
    end
    add_index :downloads, :user_id
  end

  def self.down
    drop_table :downloads
  end
end