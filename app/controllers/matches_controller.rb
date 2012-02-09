class MatchesController < BaseController

  before_filter :login_required, :except => :show
  before_filter :find_user, :except => :show
  before_filter :require_current_user, :except => :show
  before_filter :find_tournament
  skip_before_filter :login_required, :find_user, :require_current_user,
    :find_tournament, :only => :auto_complete_for_player_name

  def show
    @match = @tournament.matches.find params[:id]
    @players = @match.players
  end

  def new
    @position = params[:position].to_i
    @match = @tournament.matches.build
  end

  def create
    @position = params[:position].to_i
    @match = @tournament.matches.build params[:match]

    @players = @match.players.build params[:players].values

    if @match.save
      @match.update_attribute :position, @position
      flash[:notice] = "Match \##{@match.position} successfully created"
      redirect_to @tournament

    else
      render :action => 'new'
    end
  end

  def edit
    @match = @tournament.matches.find params[:id]
    @position = @match.position
  end

  def update
    @match = @tournament.matches.find params[:id]
    @match.attributes = params[:match]

    begin
      Match.transaction do
        @match.players.each do |p|
          p.name = params[:players][p.id.to_s][:name]
          p.save
        end

        @match.save!
        flash[:notice] = "Match \##{@match.position} successfully updated"
        redirect_to @tournament
      end

    rescue
      render :action => 'edit'
    end
  end

  def edit_winner
    @match = @tournament.matches.find params[:id]
    @players = @match.players
  end

  def update_winner
    @match = @tournament.matches.find params[:id]
    @players = @match.players

    Match.transaction do
      @match.attributes = params[:match]

      if @match.winner && @match.save
        @players.update(params[:players].keys, params[:players].values)

        create_next_match
        #next_match.update_attribute :position, next_match_position
        #player.update_attribute :position, player_position

        flash[:notice] = "Successfully declared Match \# #{@match.position} winner"
        redirect_to tournament_path(@tournament)

      else
        flash[:error] = 'A winner is required'
        render :action => 'edit_winner'
      end
    end
  end

  def forfeit
    @match = @tournament.matches.find params[:id]
    @match.update_attribute :played_at, Time.zone.now
    create_next_match

    flash[:notice] = "Successfully forfeited Match \# #{@match.position}"
    redirect_to tournament_path(@tournament)
  end

  def destroy
    @match = @tournament.matches.find params[:id]
    unless @match.played?
      @match.destroy
      flash[:notice] = "Successfully deleted Match \# #{@match.position}"

    else
      flash[:error] = "Cannot delete match that has been played"
    end
    redirect_to tournament_path(@tournament)
  end

  def auto_complete_for_player_name
    name = params[:players].shift.last[:name]
    find_options = { :order => 'name', :limit => 10,
      :conditions => ['LOWER(name) LIKE ?', "#{name.downcase}%"] }
    @teams = Team.find(:all, find_options)

    render :inline => "<%= content_tag(:ul, @teams.map { |team| content_tag(:li, h(team.name)) }) %>"
  end

  protected

    def find_tournament
      @tournament = Tournament.find params[:tournament_id]
    end

    def create_next_match
      next_match_position = (@tournament.number_of_players <= 8 ? 8 : 16) / 2 + (@match.position / 2.0).ceil
      next_match = @tournament.matches.find_by_position next_match_position
      if next_match.nil?
        next_match = @tournament.matches.build
        next_match.position = next_match_position
      end

      player = next_match.players.build
      player.player = @match.winner.player if @match.winner
      player.position = 2 % @match.position + 1

      return next_match.save
    end

end
