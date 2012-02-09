class MatchPlayer < ActiveRecord::Base

  attr_accessor :name

  belongs_to :match
  belongs_to :player, :polymorphic => true

  validate :player_found

  before_validation :set_player

  def name
    return @name if @name
    @name = player.name if player
  end

  protected

    def set_player
      self.player = Team.find_by_name(name) if name
    end

    def player_found
      errors.add_to_base("Player #{name} is invalid") if !name.blank? && player.nil?
    end

end
