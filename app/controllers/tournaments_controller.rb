class TournamentsController < BaseController

  before_filter :login_required, :except => [ :index, :tag, :show ]
  before_filter :find_user, :except => [ :index, :tag, :show ]
  before_filter :require_current_user, :except => [ :index, :tag, :show ]
  before_filter :find_or_initialize_tournament, :except => [ :index, :tag ]

  def index
    @user = current_user
    if @all = params[:all]
      @tournaments = Tournament.all
      render :action => 'tag'

    else
      @tags = Tournament.tag_counts
    end
  end

  def tag
    @tag = params[:id]
    @tournaments = Tournament.find_tagged_with @tag
    @user = current_user
  end

  def show
    @user = current_user
    @matches = @tournament.matches
  end

  def new
    render
  end

  def create
    @tournament.attributes = params[:tournament]
    @tournament.creator = @user
    @tournament.tag_list = params[:tag_list] || ''

    if @tournament.save
      flash[:notice] = 'Tournament was successfully created'
      redirect_to @tournament

    else
      render :action => 'new'
    end
  end

  def edit
    render
  end

  def update
    @tournament.attributes = params[:tournament]
    @tournament.creator = @user
    @tournament.tag_list = params[:tag_list] || ''

    if @tournament.save
      flash[:notice] = 'Tournament was successfully updated'
      redirect_to @tournament

    else
      render :action => 'edit'
    end
  end

  def destroy
    @tournament.destroy
    flash[:notice] = 'Tournament was successfully deleted'
    redirect_to tournaments_path
  end

  protected

    def find_or_initialize_tournament
      @tournament = params[:id] ? Tournament.find(params[:id]) : Tournament.new
    end

end
