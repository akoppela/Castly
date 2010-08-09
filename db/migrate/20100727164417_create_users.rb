class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string   :login,  :limit => 128, :null => false
      
      t.string   :token, :limit => 128
      t.string   :crypted_password, :null => false
      t.string   :password_salt, :null => false
      t.string   :persistence_token, :null => false
      t.string   :perishable_token, :default => "", :null => false
      
      t.integer  :login_count, :default => 0, :null => false
      t.datetime :last_login_at
      t.datetime :current_login_at
      t.string   :last_login_ip
      t.string   :current_login_ip
      
      t.string   :display_name
      
      t.boolean  :accept_notice, :default => false
      t.boolean  :accept_rules, :default => false
      t.decimal  :balance, :precision => 12, :scale => 2, :default => 0
      t.string   :time_zone
      
      t.integer :invite_limit, :null => false, :default => 0
      t.timestamps
    end
    
    add_index :users, :login
    add_index :users, :persistence_token
    add_index :users, :token
  end

  def self.down
    drop_table :users
  end
end
