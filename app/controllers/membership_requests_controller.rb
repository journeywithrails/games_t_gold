class MembershipRequestsController < BaseController

  helper :application

  before_filter :login_required
  before_filter :find_team
  before_filter :team_admin_required, :only => :accept

  uses_tiny_mce :options => AppConfig.default_mce_options, :only => [ :new, :create ]

  def new
    @membership_request = MembershipRequest.new :message => 'I wish to become a member of your team.'
  end

  def create
    @membership_request = current_user.membership_requests.build params[:membership_request]
    @membership_request.team_id = @team.id

    if @membership_request.save
      flash[:notice] = "Successfully sent membership request to #{@team.name}"
      redirect_to team_path(@team)

    else
      render :action => 'new'
    end
  end

  def destroy
    if params[:reject]
      @membership_request = @team.membership_requests.find params[:id]
      @membership_request.destroy
      flash[:notice] = "Denied request by #{@membership_request.user.display_name}"
      redirect_to team_path(@team)

    else
      if @team.admin? current_user
        @membership_request = current_user.membership_requests.find params[:id]
        @membership_request.destroy
        flash[:notice] = 'Membership request canceled'
        redirect_to teams_path

      else
        flash[:error] = 'Access denied'
        redirect_to teams_path
      end
    end
  end

  def accept
    @membership_request = @team.membership_requests.find params[:id]
    new_member = @membership_request.user
    Team.transaction do
      @team.members << new_member
      @membership_request.destroy
      flash[:notice] = "#{new_member.display_name} has been accepted as a new member"
    end

  rescue
    flash[:error] = "Unable to add #{new_member.display_name} to this team"

  ensure
    redirect_to team_path(@team)
  end

  protected

    def find_team
      @team = Team.find params[:team_id]
    end

    def team_admin_required
      return true if @team.admin?(current_user)

      flash[:error] = 'Access denied'
      redirect_to teams_path
    end

end
