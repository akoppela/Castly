class CreateSeasons < ActiveRecord::Migration
  def self.up
    create_table :seasons do |t|
      t.references :video, :null => false
      t.string :title
      t.timestamps
    end
    add_index :seasons, :video_id
  end

  def self.down
    drop_table :seasons
  end
end