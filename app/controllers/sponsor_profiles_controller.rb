class SponsorProfilesController < BaseController

  uses_tiny_mce(:options => AppConfig.default_mce_options.merge({:editor_selector => "rich_text_editor"}))

  def new
    @user = User.new((params[:user] || {}).merge(:birthday => nil))
    render :action => 'new', :layout => 'beta' and return if AppConfig.closed_beta_mode    
  end
  
  def create
    @user         = User.new(params[:user].merge(:birthday => nil, :sponsor => true))
    @user.role    = Role[:member]
    @user.inviter_id = User.find_by_login(params[:inviter]).id if !params[:inviter].nil?

    if (!AppConfig.require_captcha_on_signup || verify_recaptcha(@user)) && @user.save
      flash[:notice] = :email_signup_thanks.l_with_args(:email => @user.email) 
      redirect_to signup_completed_user_path(@user.activation_code)
    else
      render :action => 'new'
    end
  end

end
