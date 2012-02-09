module MatchesHelper

  def player_name(player, state)
    content_tag(:div, :class => 'player-name') do
      if player && player.player
        player = player.player
        name = player.name

        if state=="open"
          link_to team_logo(player, :thumb, :size => '24x24', :class => nil) + '<br/>' + name, player
        else
          team_logo(player, :thumb, :size => '24x24', :class => nil) + '<br/>' + name
        end

      else
        '(None)'
      end
    end
  end

end
