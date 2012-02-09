class CreateMatchPlayers < ActiveRecord::Migration
  def self.up
    create_table :match_players do |t|
      t.references :match
      t.integer :position

      t.references :player, :polymorphic => true
      t.string :score, :limit => 50

      t.timestamps
    end

    add_index :match_players, [ :match_id, :position ]
    add_index :match_players, [ :player_id, :player_type ]
  end

  def self.down
    drop_table :match_players
  end
end
