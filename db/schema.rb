# This file is auto-generated from the current state of the database. Instead 
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your 
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20100808131344) do

  create_table "download_files", :force => true do |t|
    t.integer  "download_id",    :null => false
    t.string   "title"
    t.integer  "common_size"
    t.integer  "completed_size"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "downloads", :force => true do |t|
    t.integer  "user_id",           :null => false
    t.string   "title"
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.integer  "file_file_size"
    t.string   "file_remote_url"
    t.boolean  "torrent"
    t.integer  "torrent_id"
    t.string   "state",             :null => false
    t.float    "procent_complete"
    t.integer  "common_size"
    t.integer  "completed_size"
    t.string   "info_hash"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "downloads", ["user_id"], :name => "index_downloads_on_user_id"

  create_table "invite_inquiries", :force => true do |t|
    t.string   "email",                           :null => false
    t.boolean  "confirmed",    :default => false
    t.datetime "confirmed_at"
    t.integer  "invite_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "invites", :force => true do |t|
    t.integer  "sender_id"
    t.integer  "recipient_id"
    t.string   "recipient_email"
    t.string   "token"
    t.datetime "accept_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "jobs", :force => true do |t|
    t.integer  "priority",          :default => 0
    t.integer  "attempts",          :default => 0
    t.text     "encoded_processor"
    t.string   "queue"
    t.string   "last_error"
    t.datetime "locked_at"
    t.datetime "processed_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pages", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "payments", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "login",             :limit => 128,                                                   :null => false
    t.string   "token",             :limit => 128
    t.string   "crypted_password",                                                                   :null => false
    t.string   "password_salt",                                                                      :null => false
    t.string   "persistence_token",                                                                  :null => false
    t.string   "perishable_token",                                                :default => "",    :null => false
    t.integer  "login_count",                                                     :default => 0,     :null => false
    t.datetime "last_login_at"
    t.datetime "current_login_at"
    t.string   "last_login_ip"
    t.string   "current_login_ip"
    t.string   "display_name"
    t.boolean  "accept_notice",                                                   :default => false
    t.boolean  "accept_rules",                                                    :default => false
    t.decimal  "balance",                          :precision => 12, :scale => 2, :default => 0.0
    t.string   "time_zone"
    t.integer  "invite_limit",                                                    :default => 0,     :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["login"], :name => "index_users_on_login"
  add_index "users", ["persistence_token"], :name => "index_users_on_persistence_token"
  add_index "users", ["token"], :name => "index_users_on_token"

  create_table "video_files", :force => true do |t|
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.integer  "file_file_size"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "videos", :force => true do |t|
    t.integer  "user_id",                           :null => false
    t.integer  "video_file_id"
    t.integer  "size"
    t.integer  "play_count"
    t.datetime "last_played"
    t.string   "title",                             :null => false
    t.integer  "sec_length",     :default => 0,     :null => false
    t.text     "description"
    t.boolean  "serial",         :default => false
    t.integer  "parent_id"
    t.integer  "episode_number", :default => 0
    t.integer  "season_number",  :default => 0
    t.integer  "sec_viewed",     :default => 0,     :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "videos", ["user_id"], :name => "index_videos_on_user_id"

end
