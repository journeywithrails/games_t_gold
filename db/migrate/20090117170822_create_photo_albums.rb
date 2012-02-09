class CreatePhotoAlbums < ActiveRecord::Migration
  def self.up
    create_table :photo_albums do |t|
      t.references :owner

      t.string :name
      t.text :description

      t.integer :position
      t.boolean :public, :default => true

      t.string :cached_tag_list, :default => nil

      t.timestamps
    end

    add_index :photo_albums, [ :owner_id, :position ], :unique => true
  end

  def self.down
    drop_table :photo_albums
  end
end
