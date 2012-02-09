require_dependency RAILS_ROOT + '/vendor/plugins/community_engine/app/models/photo'

class Photo

  belongs_to :photo_album

  named_scope :unsorted, :conditions => { :photo_album_id => nil }

  validate :photo_album_is_owned_by_photo_owner

  protected

    def photo_album_is_owned_by_photo_owner
      errors.add :photo_album, 'is not allowed access to this photo' if !photo_album_id.blank? &&
        (album = PhotoAlbum.find(photo_album_id)) && album.owner != user
    end

end
