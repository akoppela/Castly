class CreateInviteInquiries < ActiveRecord::Migration
  def self.up
    create_table :invite_inquiries do |t|
      t.string :email, :null => false
      t.boolean :confirmed, :default => false
      t.references :invite
      t.timestamps
    end
  end

  def self.down
    drop_table :invite_inquiries
  end
end
