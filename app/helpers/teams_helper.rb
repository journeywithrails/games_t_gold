module TeamsHelper

  def team_origin(team)
    content_tag :p do
      content_tag :em, "Established #{team.created_at.to_date.to_formatted_s(:long)} by #{link_to team.creator.display_name, user_path(team.creator)}"
    end
  end

  def team_logo(team, size = :thumb, options = {})
    if team.filename
      fn = size.nil? ? team.public_filename : team.public_filename(size.to_sym)

    else
      case size
      when :thumb
        fn = AppConfig.team_logo['missing_thumb']
      else
        fn = AppConfig.team_logo['missing_medium']
      end
    end
    image_tag(fn, options.reverse_merge(:class => 'polaroid', :alt => team.name))
  end

  def team_position(team, member)
    if team.creator? member
      content_tag :h4, 'Team Captain'

    elsif team.admin? member
      content_tag :h4, 'Team Admin'
    end
  end

end
