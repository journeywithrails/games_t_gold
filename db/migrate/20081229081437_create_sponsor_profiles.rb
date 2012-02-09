class CreateSponsorProfiles < ActiveRecord::Migration
  def self.up
    create_table :sponsor_profiles do |t|
      t.string :name, :limit => 255

      t.timestamps
    end
  end

  def self.down
    drop_table :sponsor_profiles
  end
end
