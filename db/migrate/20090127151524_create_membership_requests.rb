class CreateMembershipRequests < ActiveRecord::Migration
  def self.up
    create_table :membership_requests do |t|
      t.references :user
      t.references :team

      t.text :message

      t.timestamps
    end

    add_index :membership_requests, :user_id
    add_index :membership_requests, :team_id
  end

  def self.down
    drop_table :membership_requests
  end
end
