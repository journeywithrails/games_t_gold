class AssociateUsersWithProfiles < ActiveRecord::Migration
  def self.up
    add_column :users, :profile_id, :integer
    add_column :users, :profile_type, :string

    add_index :users, [ :profile_id, :profile_type ]
  end

  def self.down
    remove_index :users, :column => [ :profile_id, :profile_type ]

    remove_column :users, :profile_type
    remove_column :users, :profile_id
  end
end
