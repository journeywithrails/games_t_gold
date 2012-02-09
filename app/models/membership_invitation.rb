class MembershipInvitation < ActiveRecord::Base

  attr_accessor :to

  belongs_to :team
  belongs_to :user

  validates_presence_of :team, :user
  validates_uniqueness_of :user_id, :scope => :team_id
  validate :not_already_a_member

  protected

    def not_already_a_member
      if Membership.find_by_team_id_and_member_id team_id, user_id
        errors.add_to_base 'Already a member of this team'
      end
    end

end
