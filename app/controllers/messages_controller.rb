class MessagesController < BaseController

  skip_before_filter :find_user, :login_required, :require_ownership_or_moderator,
    :only => :auto_complete_for_message_to
  auto_complete_for :message, :to
    
  def new
    @message = Message.new(params[:message])

    if params[:reply_to]
      @reply_to = @user.received_messages.find(params[:reply_to])
      unless @reply_to.nil?
        @message.to = @reply_to.sender.login
        @message.subject = "Re: #{@reply_to.subject}"
        @message.body = "\n\n----------- Original Message Below -----------\n\n #{@reply_to.body}"
      end
    end
  end
  
  def auto_complete_for_message_to
    find_options = { :joins => 'INNER JOIN users ON friendships.friend_id = users.id',
      :conditions => ['login <> ? AND login LIKE ?', current_user.login, "#{params[:message][:to]}%"],
      :order => 'login', :limit => 10 }
    @users = current_user.friendships.find(:all, find_options).map &:friend

    render :inline => "<%= content_tag(:ul, @users.map { |user| content_tag(:li, h(user.login)) }) %>"
  end
  
end
