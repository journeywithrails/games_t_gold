require_dependency RAILS_ROOT + '/vendor/plugins/community_engine/app/models/user'

class User

  belongs_to :profile, :polymorphic => true
  has_many :photo_albums, :foreign_key => 'owner_id', :dependent => :destroy
  has_many :memberships, :foreign_key => 'member_id', :dependent => :destroy
  has_many :teams, :through => :memberships
  has_many :created_teams, :class_name => 'Team', :foreign_key => :creator_id
  has_many :membership_invitations, :dependent => :destroy do
    def from_team(team_id)
      find_by_team_id team_id
    end
  end
  has_many :membership_requests, :dependent => :destroy do
    def to_team(team_id)
      find_by_team_id team_id
    end
  end
  has_many :tournaments, :as => :creator

  named_scope :players, :conditions => { :sponsor => false }
  named_scope :sponsors, :conditions => { :sponsor => true }

  # XXX: hack to remove existing validation on birthday
  self.validate.reject! { |v| v.options[:message] == 'is an invalid date' }

  validates_associated :profile
  validates_date :birthday, :before => 13.years.ago.to_date, :if => Proc.new { |user| !user.sponsor? }

end
