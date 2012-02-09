class PhotoAlbumsController < BaseController

  before_filter :login_required, :only => [ :new, :edit, :update, :destroy, :create ]
  before_filter :find_user, :only => [ :new, :edit, :index, :show ]
  before_filter :require_current_user, :only => [ :new, :edit, :update, :destroy ]

  def new
    @user = User.find params[:user_id]
    @photo_album = PhotoAlbum.new
  end

  def create
    @user = current_user

    @photo_album = PhotoAlbum.new params[:photo_album]
    @photo_album.owner = @user
    @photo_album.tag_list = params[:tag_list] || ''

    if @photo_album.save
      flash[:notice] = 'Photo album was successfully created'
      redirect_to user_photo_album_photos_path(@user, @photo_album)

    else
      render :action => 'new'
    end
  end

  def edit
    @photo_album = PhotoAlbum.find params[:id]
    @user = @photo_album.owner
  end

  def update
    @photo_album = PhotoAlbum.find params[:id]
    @user = @photo_album.owner
    @photo_album.tag_list = params[:tag_list] || ''

    if @photo_album.update_attributes params[:photo_album]
      redirect_to user_photo_album_photos_path(@user, @photo_album)

    else
      render :action => 'edit'
    end
  end

  def destroy
    @user = User.find params[:user_id]
    @photo_album = @user.photo_albums.find params[:id]
    @photo_album.destroy
    flash[:notice] = 'Photo album was successfully deleted'
    redirect_to user_photos_path(@user)
  end

end
