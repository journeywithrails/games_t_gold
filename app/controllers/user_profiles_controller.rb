require 'rubygems'
require 'openx'

class UserProfilesController < BaseController

  uses_tiny_mce(:options => AppConfig.default_mce_options.merge({:editor_selector => "rich_text_editor"}))
  
  OpenX::Services::Base.configuration = {
    'username'  => 'kellykampen',
    'password'  => 'changeme',
    'url'       => 'http://localhost/openx/www/api/v1/xmlrpc/'
  }

  def new
    @user         = User.new( {:birthday => Date.parse((Time.now - 25.years).to_s) }.merge(params[:user] || {}) )
    @inviter_id   = params[:id]
    @inviter_code = params[:code]

    render :action => 'new', :layout => 'beta' and return if AppConfig.closed_beta_mode    
  end

  def create
    @user       = User.new(params[:user])
    @user.role  = Role[:member]
    @user.inviter_id = User.find_by_login(params[:inviter]).id if !params[:inviter].nil?

    if (!AppConfig.require_captcha_on_signup || verify_recaptcha(@user)) && @user.save
      create_friendship_with_inviter(@user, params)
      flash[:notice] = :email_signup_thanks.l_with_args(:email => @user.email) 
      redirect_to signup_completed_user_path(@user.activation_code)
    else
      render :action => 'new'
    end
  end
  
  protected

    def create_friendship_with_inviter(user, options = {})
      unless options[:inviter_code].blank? or options[:inviter_id].blank?
        friend = User.find(options[:inviter_id])

        if friend && friend.valid_invite_code?(options[:inviter_code])
          accepted    = FriendshipStatus[:accepted]
          @friendship = Friendship.new(:user_id => friend.id,
            :friend_id => user.id,
            :friendship_status => accepted,
            :initiator => true)

          reverse_friendship = Friendship.new(:user_id => user.id,
            :friend_id => friend.id,
            :friendship_status => accepted)

          @friendship.save
          reverse_friendship.save
        end
      end
    end
  
end
