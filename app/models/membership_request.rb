class MembershipRequest < ActiveRecord::Base
  
  belongs_to :user
  belongs_to :team

  validates_presence_of :user, :team
  validates_uniqueness_of :team_id, :scope => :user_id
  validate :not_already_a_member

  protected

    def not_already_a_member
      if Membership.find_by_team_id_and_member_id team_id, user_id
        errors.add_to_base 'Already a member of this team'
      end
    end

end
