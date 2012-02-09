module PhotoAlbumsHelper
  def photo_album_icon(photo_album, options = {})
    options.reverse_merge! :alt => photo_album.name, :class => 'photo-album'

    photo_album.photos.empty? ?
      image_tag(AppConfig.photo['missing_thumb'], options.merge(:size => '100x100')) :
      image_tag(photo_album.photos.first.public_filename(:thumb), options)
  end
end
