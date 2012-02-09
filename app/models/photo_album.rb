class PhotoAlbum < ActiveRecord::Base

  acts_as_list :scope => :owner
  acts_as_taggable

  belongs_to :owner, :class_name => 'User'
  has_many :photos, :dependent => :nullify

  validates_presence_of :name, :owner
  validates_uniqueness_of :name, :scope => :owner_id, :case_sensitive => false

end
