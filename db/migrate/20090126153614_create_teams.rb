class CreateTeams < ActiveRecord::Migration
  def self.up
    create_table :teams do |t|
      t.string :name, :limit => 100
      t.text :description, :description_html

      t.references :creator

      t.integer :size
      t.string :content_type
      t.string :filename
      t.integer :height, :width

      t.timestamps
    end

    add_index :teams, :creator_id
  end

  def self.down
    drop_table :teams
  end
end
