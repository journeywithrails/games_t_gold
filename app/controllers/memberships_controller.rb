class MembershipsController < BaseController

  helper :application

  before_filter :login_required
  before_filter :find_team_and_membership
  before_filter :protect_creator
  before_filter :team_admin_required, :only => [ :promote, :demote, :revoke, :destroy ]
  before_filter :current_user_required, :only => [ :terminate ]

  def promote
    @membership.update_attribute :admin, true

    flash[:notice] = "#{@membership.member.display_name} has been promoted to admin."
    redirect_to team_path(@team)
  end

  def demote
    @membership.update_attribute :admin, false

    flash[:notice] = "#{@membership.member.display_name} has been demoted."
    redirect_to team_path(@team)
  end

  def revoke
    render
  end

  def terminate
    render
  end

  def destroy
    @membership.destroy

    case request.referer
    when /revoke/
      flash[:notice] = "#{@membership.member.display_name} has been dismissed."
      redirect_to team_path(@team)

    when /terminate/
      flash[:notice] = "You are no longer a member of #{@team.name}."
      redirect_to teams_path
    end
  end

  protected

    def find_team_and_membership
      @team = Team.find params[:team_id]

      @membership = @team.memberships.find params[:id], :include => :member
      @member = @membership.member
    end

    def protect_creator
      return true unless @team.creator?(@member)

      flash[:error] = 'Access denied'
      redirect_to team_path(@team)
    end

    def team_admin_required
      return true if @team.admin?(current_user)

      flash[:error] = 'Access denied'
      redirect_to team_path(@team)
    end

    def current_user_required
      return true if current_user == @member

      flash[:error] = 'Access denied'
      redirect_to teams_path
    end

end
