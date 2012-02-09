module MembershipsHelper

  def membership_history(membership)
    "Member since #{membership.created_at.to_date.to_formatted_s(:long)}"
  end

end
