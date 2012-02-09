class SponsoreAd < ActiveRecord::Base

   has_attachment  :storage => :file_system,
                  :max_size => 2.megabytes,
                  :thumbnails => { :small => '180x150!', :thumb => '50x50!' },
                  :processor => :MiniMagick,
                  :content_type => ['image/jpg', 'image/jpeg', 'image/pjpeg', 'image/gif', 'image/png', 'image/x-png']
 
end
