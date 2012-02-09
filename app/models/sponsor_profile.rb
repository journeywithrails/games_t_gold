class SponsorProfile < ActiveRecord::Base

  has_one :owner, :as => :profile

  validates_presence_of :name
  validates_length_of :name, :maximum => 255

end
