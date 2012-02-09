class AssociatePhotosWithPhotoAlbums < ActiveRecord::Migration
  def self.up
    add_column :photos, :photo_album_id, :integer
    add_index :photos, :photo_album_id
  end

  def self.down
    remove_index :photos, :column => :photo_album_id
    remove_column :photos, :photo_album_id
  end
end
