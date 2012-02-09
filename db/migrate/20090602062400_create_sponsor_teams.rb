class CreateSponsorTeams < ActiveRecord::Migration
  def self.up
    create_table :sponsor_teams do |t|
      t.string :filename
      t.string :content_type
      t.integer :size
      t.text :description

      t.timestamps
    end
  end

  def self.down
    drop_table :sponsor_teams
  end
end
