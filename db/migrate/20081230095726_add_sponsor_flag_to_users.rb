class AddSponsorFlagToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :sponsor, :boolean, :default => false
  end

  def self.down
    remove_column :users, :sponsor
  end
end
