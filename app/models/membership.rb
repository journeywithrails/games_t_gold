class Membership < ActiveRecord::Base

  belongs_to :team
  belongs_to :member, :class_name => 'User'

  validates_presence_of :team, :member
  validates_uniqueness_of :member_id, :scope => :team_id

  named_scope :members, :conditions => { :admin => false }
  named_scope :admins, :conditions => { :admin => true }

end
