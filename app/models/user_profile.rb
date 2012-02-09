class UserProfile < ActiveRecord::Base

  has_one :owner, :as => :profile

  validates_presence_of :first_name, :last_name
  validates_length_of :first_name, :last_name, :nickname, :ethnicity,
    :maximum => 255

  def full_name
    [first_name, last_name].compact.join(' ')
  end

end
