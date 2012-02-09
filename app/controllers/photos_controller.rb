require 'pp'

class PhotosController < BaseController

  helper :photo_albums

  # GET /photos
  # GET /photos.xml
  def index
    @user = User.find(params[:user_id])

    if params[:photo_album_id]
      @photo_album = @user.photo_albums.find params[:photo_album_id], :include => :photos
      @photos = @photo_album.photos.recent

    else
      conditions = {}
      if params[:tag_name]
        conditions = { :tags => { :name => params[:tag_name] } }
      end

      @photo_albums = @user.photo_albums.find :all, :conditions => conditions, :include => [ :photos, :tags ]
      @photos = @user.photos.recent.unsorted.find :all, :conditions => conditions, :include => :tags
      @tags = Photo.tag_counts :conditions => { :user_id => @user.id }, :limit => 20
    end
      
    @rss_title = "#{AppConfig.community_name}: #{@user.login}'s photos"
    @rss_url = formatted_user_photos_path(@user,:rss)

    respond_to do |format|
      format.html # index.rhtml
      format.rss {
        render_rss_feed_for(@photos,
           { :feed => {:title => @rss_title, :link => url_for(:controller => 'photos', :action => 'index', :user_id => @user) },
             :item => {:title => :name,
                       :description => Proc.new {|photo| description_for_rss(photo)},
                       :link => Proc.new {|photo| user_photo_url(photo.user, photo)},
                       :pub_date => :created_at} })

      }
      format.xml { render :action => 'index.rxml', :layout => false}
    end
  end

  ## GET /photos/new
  def new
    @user = User.find(params[:user_id])
    @photo_album = @user.photo_albums.find params[:photo_album_id] if params[:photo_album_id]
    @photo = Photo.new

    if params[:inline]
      render :action => 'inline_new', :layout => false
    end
  end

  ## POST /photos
  ## POST /photos.xml
  def create
    @user = current_user

    @photo = Photo.new(params[:photo])
    @photo.user = @user
    if params[:photo_album_id]
      @photo_album = @user.photo_albums.find params[:photo_album_id]
      @photo.photo_album = @photo_album
    end
    @photo.tag_list = params[:tag_list] || ''

    respond_to do |format|
      if @photo.save
        #start the garbage collector
        GC.start
        flash[:notice] = :photo_was_successfully_created.l

        format.html {
          render :action => 'inline_new', :layout => false and return if params[:inline]
          redirect_to user_photo_url(:id => @photo, :user_id => @photo.user)
        }
        format.js {
          responds_to_parent do
            render :update do |page|
              page << "upload_image_callback('#{@photo.public_filename()}', '#{@photo.display_name}', '#{@photo.id}');"
            end
          end
        }
      else
        format.html {
          render :action => 'inline_new', :layout => false and return if params[:inline]
          render :action => "new"
        }
        format.js {
          responds_to_parent do
            render :update do |page|
              page.alert(:sorry_there_was_an_error_uploading_the_photo.l)
            end
          end
        }
      end
    end
  end

end
