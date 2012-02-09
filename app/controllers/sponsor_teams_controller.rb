class SponsorTeamsController < BaseController
   helper :application
   
   def create  
      @sponsore_team=SponsorTeam.new
      @sponsore_team.attributes = params[:sponsor_team]
      @sponsore_team.sponsor_id=current_user.id
      @sponsore_team.team_id=params[:id]
     
      if @sponsore_team.save
        flash[:notice] = 'Sponsored Ad successfully created'
        redirect_to teams_path    
      end
   end
   
   def change_status
       @sponsor_team = SponsorTeam.find(:first, :conditions => ["team_id LIKE ? and sponsor_id LIKE ?",params[:id],params[:sid]])
     if params[:status]=="1"
       @sponsor_team.accept=1
     elsif params[:status]=="0"
       @sponsor_team.accept=0
     end 
     
     if@sponsor_team.save!
       redirect_to team_path(params[:id])
     end
   end   
end
