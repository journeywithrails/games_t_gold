require 'rubygems'
require 'google_geocode'

class SponsorsController < BaseController
#  before_filter :sponsor_required
  def index   
   @gg = GoogleGeocode.new "ABQIAAAAzr2EBOXUKnm_jVnk0OJI7xSosDVG8KKPE1-m51RBrvYughuyMxQ-i1QfUnH94QxWIa6N4U6MouMmBA"

   cond, @search, @metro_areas, @states = User.paginated_users_conditions_with_search(params)    
    
    @users = User.recent.find(:all,
      :conditions => cond.to_sql, 
      :include => [:tags], 
      :page => {:current => params[:page], :size => 20}
      )
    
    @tags = User.tag_counts :limit => 10
    
    setup_metro_areas_for_cloud
    @lat=37.09024
    @long=-95.712891
    @sponsors= User.find_by_sql "SELECT count( * ) AS count, users.country_id as cid, users.state_id as sid, users.metro_area_id as aid, countries.name AS cname, states.name AS sname, metro_areas.name AS area
FROM `users` , countries, states, metro_areas
WHERE users.country_id = countries.id
AND users.state_id = states.id
AND users.metro_area_id = metro_areas.id
AND users.sponsor =1
GROUP BY countries.name, states.name, metro_areas.name"   
    
    if(!params[:country_id].nil? && !params[:state_id].nil? && !params[:metro_area_id].nil?)  
       @query= "SELECT count( * ) AS count, users.country_id as cid, users.state_id as sid, users.metro_area_id as aid, countries.name AS cname, states.name AS sname, metro_areas.name AS area FROM `users` , countries, states, metro_areas WHERE users.country_id = countries.id
AND users.state_id = states.id
AND users.metro_area_id = metro_areas.id
AND users.country_id = #{params[:country_id]} AND users.state_id = #{params[:state_id]} AND users.metro_area_id = #{params[:metro_area_id]} AND users.sponsor =1 group by cname,sname,area"         
       @sponsors= User.find_by_sql @query  
    elsif(!params[:country_id].nil? && params[:state_id].blank? && params[:metro_area_id].blank?)  
       @query= "SELECT count( * ) AS count, users.country_id as cid, users.state_id as sid, users.metro_area_id as aid, countries.name AS cname, states.name AS sname, metro_areas.name AS area FROM `users` , countries, states, metro_areas WHERE users.country_id = countries.id
AND users.state_id = states.id
AND users.metro_area_id = metro_areas.id
AND users.country_id = #{params[:country_id]} AND users.sponsor =1 group by cname, sname, area"         
       @sponsors= User.find_by_sql @query      
    end
  end
  
  def showaddress
    cond, @search, @metro_areas, @states = User.paginated_users_conditions_with_search(params)    
    
    @users = User.recent.find(:all,
      :conditions => cond.to_sql, 
      :include => [:tags], 
      :page => {:current => params[:page], :size => 20}
      )
    
    @tags = User.tag_counts :limit => 10
    
    setup_metro_areas_for_cloud    
  end
  
  def sponsor_users
    if(!params[:country_id].nil? && !params[:state_id].nil? && !params[:metro_area_id].nil?)
       @query= "SELECT distinct users.country_id as cid, users.state_id as sid, users.metro_area_id as aid, countries.name AS cname, states.name AS sname, metro_areas.name AS area, vendor, featured_writer, login_slug, login, created_at, description FROM `users` , countries, states, metro_areas WHERE users.country_id = countries.id
AND users.state_id = states.id
AND users.metro_area_id = metro_areas.id
AND users.country_id = #{params[:country_id]} AND users.state_id = #{params[:state_id]} AND users.metro_area_id = #{params[:metro_area_id]} and users.sponsor=1"               
       @users= User.find_by_sql @query  
       setup_metro_areas_for_cloud         
    end
  end
  
  def sponsor_this_user
   
  end
  
  def sponsor_this_team
    
  end
  
   protected  
    def setup_metro_areas_for_cloud
      @metro_areas_for_cloud = MetroArea.find(:all, :conditions => "users_count > 0", :order => "users_count DESC", :limit => 100)
      @metro_areas_for_cloud = @metro_areas_for_cloud.sort_by{|m| m.name}
    end  
  
    def setup_locations_for(user)
      metro_areas = states = []
          
      states = user.country.states if user.country
      
      metro_areas = user.state.metro_areas.all(:order => "name") if user.state
    
      return metro_areas, states
    end

    def admin_or_current_user_required
      current_user && (current_user.admin? || @is_current_user) ? true : access_denied     
    end      
end
