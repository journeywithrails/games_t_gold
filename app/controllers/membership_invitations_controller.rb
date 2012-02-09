class MembershipInvitationsController < BaseController

  helper :application

  before_filter :login_required, :except => :auto_complete_for_membership_invitation_to
  before_filter :find_team, :except => :auto_complete_for_membership_invitation_to
  before_filter :team_admin_required, :only => [ :new, :create ]

  auto_complete_for :membership_invitation, :to
  uses_tiny_mce :options => AppConfig.default_mce_options, :only => [ :new, :create ]

  def show
    @membership_invitation = current_user.membership_invitations.from_team @team
  end

  def new
    @membership_invitation = MembershipInvitation.new :message => 'We would like you to join our team.'
  end

  def create
    @membership_invitation = @team.membership_invitations.build params[:membership_invitation]
    @membership_invitation.user = User.find_by_login params[:membership_invitation][:to]

    if @membership_invitation.save
      flash[:notice] = "Successfully sent membership invitation to #{@team.name}"
      redirect_to team_path(@team)

    else
      render :action => 'new'
    end
  end

  def destroy
    if params[:reject]
      @membership_invitation = current_user.membership_invitations.find params[:id]
      @membership_invitation.destroy
      flash[:notice] = "Rejected invitation by #{@membership_invitation.team.name}"
      redirect_to teams_path

    else
      if @team.admin? current_user
        @membership_invitation = @team.membership_invitations.find params[:id]
        @membership_invitation.destroy
        flash[:notice] = 'Membership invitation canceled'
        redirect_to team_path(@team)

      else
        flash[:error] = 'Access denied'
        redirect_to teams_path
      end
    end
  end

  def accept
    @membership_invitation = current_user.membership_invitations.from_team @team

    Team.transaction do
      @team.members << current_user
      @membership_invitation.destroy
      flash[:notice] = "You are now a member of #{@team.name}"
    end

  rescue
    flash[:error] = "Unable to become a of this team"

  ensure
    redirect_to team_path(@team)
  end

  def auto_complete_for_membership_invitation_to
    find_options = { :joins => 'INNER JOIN users ON friendships.friend_id = users.id',
      :conditions => ['login <> ? AND login LIKE ?', current_user.login,
        "#{params[:membership_invitation][:to]}%"],
      :order => 'login', :limit => 10 }
    @users = current_user.friendships.find(:all, find_options).map &:friend

    render :inline => "<%= content_tag(:ul, @users.map { |user| content_tag(:li, h(user.login)) }) %>"
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
