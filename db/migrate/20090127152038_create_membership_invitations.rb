class CreateMembershipInvitations < ActiveRecord::Migration
  def self.up
    create_table :membership_invitations do |t|
      t.references :team
      t.references :user

      t.text :message

      t.timestamps
    end

    add_index :membership_invitations, :team_id
    add_index :membership_invitations, :user_id
  end

  def self.down
    drop_table :membership_invitations
  end
end
