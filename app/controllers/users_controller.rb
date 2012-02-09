class UsersController < BaseController

  def index
    cond, @search, @metro_areas, @states = User.paginated_users_conditions_with_search(params)

    @users = User.players.recent.find(:all,
      :conditions => cond.to_sql,
      :include => [:tags],
      :page => {:current => params[:page], :size => 20}
    )

    @tags = User.tag_counts :limit => 10

    setup_metro_areas_for_cloud
  end

  def show
    @friend_count               = @user.accepted_friendships.count
    @accepted_friendships       = @user.accepted_friendships.find(:all, :limit => 5).collect{|f| f.friend }
    @pending_friendships_count  = @user.pending_friendships.count()

    @comments       = @user.comments.find(:all, :limit => 10, :order => 'created_at DESC')
    @photo_comments = Comment.find_photo_comments_for(@user)    
    @users_comments = Comment.find_comments_by_user(@user, :limit => 5)

    @recent_posts   = @user.posts.find(:all, :limit => 2, :order => "published_at DESC")
    @clippings      = @user.clippings.find(:all, :limit => 5)
    @photos         = @user.photos.find(:all, :limit => 5)
    @comment        = Comment.new(params[:comment])

    update_view_count(@user) unless current_user && current_user.eql?(@user)

    @profile        = @user.profile
    @teams          = @user.teams

    @sponsors = SponsoreAd.find(:all, :conditions => ["user_id LIKE ?",@user.id])
    render_profile_template
  end

  # just shows a "user account" type selection page whose links direct to the
  # actual user account creation
  def new
    render
  end

  def edit 
    @metro_areas, @states = setup_locations_for(@user)
    @skills               = Skill.find(:all)
    @offering             = Offering.new
    @avatar               = Photo.new
    @profile              = @user.profile

    render_profile_template
  end

  def update
    @user.attributes      = params[:user]
    @metro_areas, @states = setup_locations_for(@user)

    unless params[:metro_area_id].blank?
      @user.metro_area  = MetroArea.find(params[:metro_area_id])
      @user.state       = (@user.metro_area && @user.metro_area.state) ? @user.metro_area.state : nil
      @user.country     = @user.metro_area.country if (@user.metro_area && @user.metro_area.country)
    else
      @user.metro_area = @user.state = @user.country = nil
    end

    @avatar       = Photo.new(params[:avatar])
    @avatar.user  = @user

    @user.avatar  = @avatar if @avatar.save
    
    @user.tag_list = params[:tag_list] || ''

    @profile       = @user.sponsor? ? SponsorProfile.create(params[:profile]) : UserProfile.create(params[:profile])
    @user.profile  = @profile

    if @user.save!
      @user.track_activity(:updated_profile)
      
      flash[:notice] = :your_changes_were_saved.l
      unless params[:welcome] 
        redirect_to user_path(@user)
      else
        redirect_to :action => "welcome_#{params[:welcome]}", :id => @user
      end
    end
  rescue ActiveRecord::RecordInvalid
    unless params[:from]
      render_profile_template 'edit'
    else
      render_profile_template("welcome_#{params[:from]}")
    end
  end

  def welcome_about
    @user = User.find(params[:id])
    @profile = @user.profile
    @metro_areas, @states = setup_locations_for(@user)

    render_profile_template
  end
  
  def ad_stats
    
  end

  protected

    def render_profile_template(action = action_name)
      template_dir = @user.sponsor? ? 'sponsor' : 'user'
      render :template => "/#{template_dir}_profiles/#{action}"
    end

end
