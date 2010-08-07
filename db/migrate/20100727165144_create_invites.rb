class CreateInvites < ActiveRecord::Migration
  def self.up
    create_table :invites do |t|
      t.references :sender
      t.references :recipient
      t.string     :recipient_email
      t.string     :token
      
      t.timestamp  :accept_at
      t.timestamps
    end
  end

  def self.down
    drop_table :invites
  end
end
