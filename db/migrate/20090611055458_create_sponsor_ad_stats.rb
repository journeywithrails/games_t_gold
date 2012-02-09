class CreateSponsorAdStats < ActiveRecord::Migration
  def self.up
    create_table :sponsor_ad_stats do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :sponsor_ad_stats
  end
end
