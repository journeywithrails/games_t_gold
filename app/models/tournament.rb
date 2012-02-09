class Tournament < ActiveRecord::Base
#  has_attachment prepare_options_for_attachment_fu(AppConfig.photo['attachment_fu_options'])

  has_attachment :content_type => :image, 
                 :storage => :file_system, 
                 :max_size => 500.kilobytes,
                 :resize_to => '320x200>',
                 :thumbnails => { :thumb => '100x100>' }

#  validates_as_attachment

  
  acts_as_taggable

  belongs_to :creator, :polymorphic => true
  has_many :matches, :order => 'position', :dependent => :destroy

  validates_presence_of :creator, :name, :description, :from, :number_of_players
  validates_length_of :name, :venue, :maximum => 255
  validates_date :from
  validates_date :to, :signup_date, :allow_nil => true
  validate :date_range
  validates_numericality_of :number_of_players, :only_integer => true,
    :greater_than => 0, :less_than_or_equal_to => 16
  validate :cant_change_number_of_players_once_started, :on => :update

  attr_protected :creator

  def schedule
    if to.nil? || from == to
      from.to_formatted_s :long

    else
      "#{from.to_formatted_s(:long)} to #{to.to_formatted_s(:long)}"
    end
  end

  def admin?(user)
    return user == creator if User === creator
    return creator.admin?(user) if Team === creator
  end

  def signup_closed?
    !signup_date || signup_date < Date.today
  end

  def first_round_cutoff
    return 4 if number_of_players <= 8
    return 8 if number_of_players <= 16
  end

  def last_round_match_number
    return 7 if number_of_players <= 8
    return 14 if number_of_players <= 16
  end

  def first_round?(position)
    position <= first_round_cutoff
  end

  def players_so_far
    MatchPlayer.count :all, :include => :match,
      :conditions => [ 'matches.position <= ? AND match_players.match_id IN (?) AND NOT match_players.player_id IS NULL',
        first_round_cutoff, matches.map(&:id) ]
  end

  def slots_available?
    players_so_far < number_of_players
  end

  protected

    def date_range
      errors.add_to_base 'Start date should be less than or equal to end date' \
        if from && to && (from > to)
    end

    def cant_change_number_of_players_once_started
      errors.add :number_of_players, "cannot be changed once matches have been created" \
        if number_of_players_changed? && !matches.empty?
    end

end
