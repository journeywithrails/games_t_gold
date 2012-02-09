class RemoveMatchesTournamentPositionIndex < ActiveRecord::Migration
  def self.up
    remove_index :matches, [ :tournament_id, :position ]
  end

  def self.down
    add_index :matches, [ :tournament_id, :position ], :unique => true
  end
end
