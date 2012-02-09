class Match < ActiveRecord::Base

  belongs_to :tournament
  belongs_to :winner, :class_name => 'MatchPlayer'
  has_many :players, :class_name => 'MatchPlayer', :order => 'position',
    :limit => 2, :dependent => :destroy

  validates_presence_of :tournament
  validates_date_time :schedule, :played_at, :allow_nil => true
  validates_associated :players
  validate :tournament_player_limit

  attr_protected :position

  def scheduled?
    !schedule.blank?
  end

  def played?
    !played_at.blank?
  end

  def expired?
    !played? && scheduled? && Time.zone.now > schedule
  end

  def forfeited?
    played? && winner.nil?
  end

  protected

    def tournament_player_limit
      errors.add_to_base "Maximum number of tournament players exceeded" \
        unless tournament.players_so_far + players.select { |p| !p.player.nil? }.size <= tournament.number_of_players
    end

end
