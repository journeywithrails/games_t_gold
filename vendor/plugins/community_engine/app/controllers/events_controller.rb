class EventsController < BaseController
  uses_tiny_mce(:options => AppConfig.default_mce_options, :only => [:new, :edit, :create, :update ])

#  before_filter :admin_required, :except => [:index, :show]
 before_filter :login_required, :except => [ :index]

  def show
    @event = Event.find(params[:id])
  end

  def index
    @is_admin_user = (current_user && current_user.admin?)
    @events = Event.upcoming.find(:all, :page => {:current => params[:page]})
  end

  def new
    @event = Event.new(params[:event])
  end
  
  def edit
    @event = Event.find(params[:id])
  end
    
  def create
    @event = Event.new(params[:event])
    @event.user = current_user
    
    respond_to do |format|
      if @event.save
        flash[:notice] = :event_was_successfully_created.l
        
        format.html { redirect_to events_path }
      else
        format.html { render :action => "new" }
      end
    end    
  end

  def update
    @event = Event.find(params[:id])
    if params[:metro_area_id]
      @event.metro_area = MetroArea.find(params[:metro_area_id])
    else
      @event.metro_area = nil
    end
    
    
    respond_to do |format|
      if @event.update_attributes(params[:event])
        format.html { redirect_to events_path }
      else
        format.html { render :action => "edit" }
      end
    end
  end
  
  # DELETE /homepage_features/1
  # DELETE /homepage_features/1.xml
  def destroy
    @event = Event.find(params[:id])
    @event.destroy
    
    respond_to do |format|
      format.html { redirect_to events_path }
    end
  end


end