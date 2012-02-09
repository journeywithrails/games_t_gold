class CreateTournaments < ActiveRecord::Migration
  def self.up
    create_table :tournaments do |t|
      t.references :creator, :polymorphic => true

      t.string :name, :limit => 255
      t.text :description

      t.date :from, :to
      t.string :venue, :limit => 255
      t.date :signup_date
      t.boolean :signup_online

      t.integer :number_of_players
      t.text :rules

      t.timestamps
    end

    add_index :tournaments, [ :creator_id, :creator_type ]
  end

  def self.down
    drop_table :tournaments
  end
end
