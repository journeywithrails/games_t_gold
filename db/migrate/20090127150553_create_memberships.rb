class CreateMemberships < ActiveRecord::Migration
  def self.up
    create_table :memberships do |t|
      t.references :team
      t.references :member

      t.boolean :admin, :default => false

      t.timestamps
    end

    add_index :memberships, :team_id
    add_index :memberships, :member_id
  end

  def self.down
    drop_table :memberships
  end
end
