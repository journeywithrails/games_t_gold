module TournamentsHelper

  def tournament_logo(tournament)
    creator = tournament.creator
    if User === creator
      image_tag creator.avatar_photo_url(:thumb), :class => 'polaroid'

    elsif Team === creator
      team_logo creator
    end
  end

  def scoreline(players)
    s1 = players[0].score if players[0]
    s2 = players[1].score if players[1]

    return '(no scores)' if s1.blank? && s2.blank?
    [s1, s2].map { |s| s.blank? ? '(no score)' : s } * ' - '
  end

  def play_time_left(match)
    '(' +
      (match.expired? ? 
        'Time Expired' :
        "#{distance_of_time_in_words(match.schedule, Time.zone.now)} left") +
      ')'
  end

  def match_summary(matches, position)
    match = matches.detect { |m| m.position == position }

    content_tag(:div, :class => 'match') do
      if match
        if position > @tournament.last_round_match_number
          match = matches.detect { |m| m.position == position - 1 }
          l = player_name match.winner, Tournament.find_by_id(match.tournament_id).status
          t = content_tag(:strong, "Winner: #{l}")
          t += content_tag(:div, '&nbsp;')

        else
          l = player_name match.players[0], Tournament.find_by_id(match.tournament_id).status 	 
          t = match.played? && match.winner == match.players[0] ? content_tag(:strong, l) : l

          if match.forfeited?
            l = '(forfeited)'

          else
            l = match.played? ? scoreline(match.players) : (match.schedule ? play_time_left(match) : 'versus')
          end
          
          if(Tournament.find_by_id(match.tournament_id).status=="open")
             t += link_to l, tournament_match_path(match.tournament, match)
          else
            t += l
          end

          l = player_name match.players[1], Tournament.find_by_id(match.tournament_id).status  	 
          t += match.played? && match.winner == match.players[1] ? content_tag(:strong, l) : l
        end

        t

      elsif logged_in? && @tournament.admin?(current_user) && @tournament.first_round?(position) && @tournament.slots_available?
        link_to "Create Match #{position}", new_user_tournament_match_path(@user, @tournament, :position => position)

      else
        '&nbsp;'
      end
    end
  end

end
