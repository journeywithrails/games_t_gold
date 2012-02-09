class CreateMatches < ActiveRecord::Migration
  def self.up
    create_table :matches do |t|
      t.references :tournament
      t.integer :position
      t.datetime :schedule

      t.references :winner
      t.datetime :played_at

      t.timestamps
    end

    add_index :matches, [ :tournament_id, :position ], :unique => true
    add_index :matches, :winner_id
  end

  def self.down
    drop_table :matches
  end
end
