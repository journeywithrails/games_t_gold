class TeamsController < BaseController

  helper :application

  before_filter :login_required, :except => [ :index, :show ]
  before_filter :find_or_initialize_team
  before_filter :team_admin_required, :only => [ :edit, :update, :dissolve, :destroy, :set_as_top_member ]

  uses_tiny_mce :options => AppConfig.default_mce_options, :only => [ :show, :new, :create, :edit, :update ]
  
  def index
    @teams = Team.find :all, :conditions => 'parent_id IS NULL'

    respond_to do |format|
      format.html
      format.xml { render :xml => @teams.to_xml }
    end
  end

  def show
    @memberships = @team.memberships.find :all, :include => :member, :order => "top_member desc"
    #render :text => @memberships.each { |x| x.inspect } and return
    @arr=Array.new
    for @t in @memberships
     @arr << @t.id
    end
    #render :text => @arr.inspect and return
    @membership_requests = @team.membership_requests
    @membership_invitations = @team.membership_invitations
    
    @sponsors = SponsorTeam.find(:all, :conditions => ["team_id LIKE ?", params[:id]])

    @team_comments = @team.comments.find :all, :limit => 10, :order => 'created_at DESC'
    @comment = Comment.new params[:comment]

    respond_to do |format|
      format.html
      format.xml do
        render :xml => @team.to_xml
      end
    end
  end

  def new
    render
  end
  
  def create
    @team.attributes = params[:team]
    @team.creator = current_user
    @team.tag_list = params[:tag_list] || ''
    if @team.save
      flash[:notice] = 'Team successfully created'
      respond_to do |format|
        format.html { redirect_to team_path(@team) }
        format.xml  { head :created, :location => formatted_team_url(:id => @team, :format => :xml) }
      end
    else
      respond_to do |format|
        format.html { render :action => 'new' }
        format.xml  { render :xml => @team.errors.to_xml }
      end
    end
  end

  def edit
    render
  end

  def update
    @team.attributes = params[:team]
    @team.tag_list = params[:tag_list] || ''
    if @team.save
      flash[:notice] = 'Team profile successfully updated'
      respond_to do |format|
        format.html { redirect_to team_path(@team) }
        format.xml  { head 200 }
      end

    else
      respond_to do |format|
        format.html { render :action => 'edit' }
        format.xml  { render :xml => @team.errors.to_xml }
      end
    end
  end

  def dissolve
    render
  end
  
  def destroy
    @team.destroy
    flash[:notice] = 'Team successfully dissolved'
    respond_to do |format|
      format.html { redirect_to teams_path }
      format.xml  { head 200 }
    end
  end
  
  def set_as_top_member 
    @team_captain = Membership.find(:first, :conditions => ["team_id like ? and member_id like ?",params[:id],@team.creator_id])
    if @team_captain.top_member==0
      @team_captain.top_member=2
      @team_captain.save
    end
    @team.attributes = params[:team]      
    if @team.top_members.blank?
      @team.top_members=params[:tid]
    else     
     @team.top_members= @team.top_members+','+params[:tid]
    end 
   @team.save   
   @member = Membership.find(:first, :conditions => ["team_id like ? and member_id like ?",params[:id],params[:tid]])
   @member.top_member = 1
   @member.save
   redirect_to team_path(params[:id])and return   
  end
  
  def deselect_from_top_members
    @team = Team.find(params[:id])
    if !@team.top_members.blank?
      @top_members=@team.top_members.split(',')   
      @top_members.delete(params[:tid])     
    end 
   @team.top_members=@top_members.join(',')
   @team.save 
   @member = Membership.find(:first, :conditions => ["team_id like ? and member_id like ?",params[:id],params[:tid]])
   @member.top_member = 0
   @member.save
   redirect_to team_path(params[:id])and return   
  end
  
  protected

    def team_admin_required
      return true if @team.admin?(current_user)

      flash[:error] = 'Access denied'
      redirect_to teams_path
    end

    def find_or_initialize_team
      @team = params[:id] ? Team.find(params[:id]) : Team.new
    end

end
