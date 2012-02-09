class CreateSponsorTeamStats < ActiveRecord::Migration
  def self.up
    create_table :sponsor_team_stats do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :sponsor_team_stats
  end
end
