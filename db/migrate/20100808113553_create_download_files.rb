class CreateDownloadFiles < ActiveRecord::Migration
  def self.up
    create_table :download_files do |t|
      t.references :download, :null => false
      
      t.timestamps
    end
  end

  def self.down
    drop_table :download_files
  end
end
